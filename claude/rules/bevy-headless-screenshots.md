# Running a Bevy app and screenshotting it without a window appearing

Verifying a change by running the game is normal; a window popping up over the user's work
and stealing focus is not. On this machine any Bevy app can render and screenshot itself
with **no window on screen, no focus change, no cursor grab and no sound** — the window is
created but never *mapped*.

An unmapped X11 window is still a real drawable: it gets a Vulkan swapchain, renders on the
real GPU (RTX 4070, not a software fallback), and `Screenshot::primary_window()` captures
that frame. The window manager never sees it, because WMs act on `MapRequest`.

Requires nothing installed — just `DISPLAY` set. (There is **no Xvfb** on this machine and
**no passwordless sudo**, so `xvfb-run` is not an option; this route needs neither.)

If the project already has a headless lever, use it instead of adding another —
`cathedralbevy` has `CATHEDRAL_HEADLESS=1`, see its `.claude/rules/CATHEDRAL_DRIVE.md`.

## The recipe

Gate it behind an env var so the human's own runs are unaffected. Verified on Bevy 0.19;
the `Screenshot` component + observer API is 0.15+ (older versions use `ScreenshotManager`).

```rust
let headless = std::env::var_os("HEADLESS").is_some();

let mut plugins = DefaultPlugins.set(WindowPlugin {
    primary_window: Some(Window {
        resolution: (1280, 720).into(),
        // The whole trick. Winit never maps it; it renders anyway.
        visible: !headless,
        ..default()
    }),
    ..default()
});
if headless {
    // A run you cannot see is one you do not want to hear.
    plugins = plugins.disable::<bevy::audio::AudioPlugin>();
}

let mut app = App::new();
app.add_plugins(plugins);
if headless {
    // `AudioPlugin` is what registers this asset type; anything that still calls
    // `asset_server.load::<AudioSource>` panics on handle allocation without it.
    app.init_asset::<bevy::audio::AudioSource>();
    // An unmapped window is never focused, and the default unfocused mode throttles
    // the app to a reactive 60 Hz. Let it tick like the window it cannot show.
    app.insert_resource(WinitSettings {
        focused_mode: UpdateMode::Continuous,
        unfocused_mode: UpdateMode::Continuous,
    });
}
```

Then capture — and **exit only once the capture has reached the disk**:

```rust
use bevy::render::view::screenshot::{Screenshot, ScreenshotCaptured, save_to_disk};

let saved = Arc::new(AtomicBool::new(false));   // keep a clone in a Local/Resource
commands
    .spawn(Screenshot::primary_window())
    .observe(save_to_disk(path))
    .observe({
        let saved = saved.clone();
        move |_: On<ScreenshotCaptured>| saved.store(true, Ordering::Release)
    });
// …in a later frame:
if saved.load(Ordering::Acquire) { exit.write(AppExit::Success); }
```

Writing `AppExit` on the frame that spawns the `Screenshot` produces **no file at all** —
measured, not guessed. The capture is finished by the render world a frame or more later.
Give the scene time to load first (~120 frames, or a couple of seconds).

## Three traps that make a headless run lie to you

1. **The real mouse steers the headless camera.** Winit's X11 backend delivers *raw*
   `DeviceEvent::MouseMotion` to unfocused clients, and Bevy forwards it unconditionally.
   A hidden window with a mouse-look system will be swung around by whatever the human is
   doing in another window, and the screenshot faces somewhere nobody chose. Gate the
   look system on the window, not on focus:

   ```rust
   fn mouse_look(window: Single<&Window, With<PrimaryWindow>>, /* … */) {
       if !window.visible { return; }
   ```

2. **Cursor grab.** Leave `grab_mode` exactly as the visible app has it — gameplay code
   often reads it as "gameplay owns the input" (chat open? interaction prompt live?), so
   releasing it makes the headless run behave differently from the run it stands in for.
   X refuses to confine the pointer to an unmapped window, so the human's cursor is safe
   either way. The resulting startup line is expected, and is the mechanism working:

   ```
   ERROR bevy_winit::winit_windows: Unable to grab cursor: … confine location not viewable
   ```

3. **Dropping `AudioPlugin` changes more than volume.** Its systems and asset loaders go
   with it, so sound-related logs disappear and any ungated sound load turns into
   `Could not find an asset loader matching: … .wav`. Both expected. Keep a
   `HEADLESS_AUDIO=1` escape hatch for runs that are *about* sound. Do not instead try to
   mute by setting `GlobalVolume` to zero: it is applied only when a sink is created, and
   any code that later calls `sink.set_volume(…)` (fades, ducking) overwrites it.

## Proving it stayed invisible

Don't take the screenshot's existence as proof the window never showed. Watch X while it
runs — the window must report `IsUnMapped` throughout and must never be the focus target:

```sh
HEADLESS=1 cargo run &
g=$!
while kill -0 $g 2>/dev/null; do
  for id in $(xdotool search --name "<window title>"); do
    xwininfo -id "$id" | grep "Map State"
    [[ "$(xdotool getwindowfocus)" == "$id" ]] && echo "!!! FOCUS STOLEN"
  done
  sleep 0.5
done
```

`xdotool search --onlyvisible --name "<title>"` returning nothing during the run is the
same claim, stated the short way. (Don't read a plain focus change as failure — the human
alt-tabbing between their own windows shows up there too. Compare against the game's own
window id.)

## Caveats

- **Wayland.** Bevy documents `Window::visible` as unsupported there, and an unmapped
  Wayland surface gets no frame callbacks anyway. This machine's session is X11
  (`XDG_SESSION_TYPE=x11`), which is what the above was verified on. On a Wayland session,
  run with `WAYLAND_DISPLAY=` cleared so winit takes the X11/XWayland path.
- **No display at all** (ssh, CI, `DISPLAY` unset): this recipe does not apply — winit
  cannot make an event loop. Use Bevy's `headless_renderer` example instead: render a
  camera to an `Image` target and copy it back to the CPU, with no `WinitPlugin`.
- Screenshots come out at the *physical* size — the logical resolution times the display's
  scale factor (1280x720 asked for, 1493x840 written here). Check the PNG's dimensions
  before comparing two shots pixel for pixel.
