When writing and writing Python code, use `uv` as the default (not pip).

--

If I say `tp`, that means "open the file in vim in a new pane" (`tp somefile.py` -> use somefile.py):

`tmux split-window -t s0:3 "vim /tmp/company_names.csv"`

--

Om jag säger ESPFEIT ('en subagent per featre, en i taget'),
t.ex. "ESPFEIT 3-5 i bugglista.md" betyder det
"Lös problemen med en subagent per feature, en i taget" (så varje får tom kontext = best accuracy)

--

If a message I tell you starts with `q`, that means I'm just asking a question - do NOT
try to implement it, just discuss it with me. For example,

`q a different colorscheme` means "I want to ask you about using a different color scheme",
NOT "change the colorscheme".

@RTK.md

--

Whenever I ask you to generate word documents, use python-docx (use an uv inline script),
also convert it to .pdf using `soffice --headless --convert-to pdf --outdir <dir> <file.docx>`
and after the first time generating it, open the pdf.

--

## Scraping websites (WebFetch-blocked sites like blocket.se)

See ~/.claude/rules/scraping.md
