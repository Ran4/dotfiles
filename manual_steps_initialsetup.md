# Zpresto

Update the ~/.zpreztorc by setting the theme to rangiddie

# Firefox

In Linux (well, *NIX \ OS X):

Setting up alt as main modkey for Firefox (?):
Start about:config, set these values:

    ui.key.accelKey 18
    ui.key.menuAccessKey 0

No need to change in Firefox 50, but could change in the future:

    ui.key.generalAccessKey -1

Also, to setup emacs keybindings:

```bash
echo "[Settings]\ngtk-key-theme-name = Emacs" >> ~/.config/gtk-3.0/settings.ini
```

----------------    

# vimium for chrome 

paste custom key mappings:

```
# Insert your preferred key mappings here.
unmap f
unmap F
map F LinkHints.activateMode
map f LinkHints.activateModeToOpenInNewTab

unmap h
unmap l
map h previousTab
map l nextTab

unmap a
unmap d
unmap A
unmap D
map a previousTab
map d nextTab
map A moveTabLeft
map D moveTabRight

map c scrollDown
map z scrollUp

map <c-d> scrollPageDown
map <c-u> scrollPageUp

map <backspace> goBack
map <s-backspace> goForward

map H goBack
map L goForward

set noautofocus
```

previous patterns:
prev,previous,back,older,<,‹,←,«,≪,<<,föregående,tidigare,äldre

next <patterns:>
next,more,newer,>,›,→,»,≫,>>,nästa,senare,nyare

CSS for link hints

```
div > .vimiumHintMarker {
/* linkhint boxes */
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FFF785),
  color-stop(100%,#FFC542));
  border: 1px solid #E3BE23;
  }

  div > .vimiumHintMarker span {
  /* linkhint text */
  color: black;
  font-weight: bold;
  font-size: 12px;
  }

  div > .vimiumHintMarker > .matchingCharacter {
  }
```
