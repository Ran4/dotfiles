" Extensionless scripts with a `#!/usr/bin/env -S uv run --script` (or uvx) shebang.
" `set`, not `setfiletype`: nvim has already guessed `conf` by the time this runs.
autocmd BufNewFile,BufRead * if getline(1) =~# '^#!.*\<uvx\?\>' | set filetype=python | endif
