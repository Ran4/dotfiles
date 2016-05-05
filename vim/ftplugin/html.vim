"colorscheme cful256mod

"Type << or >> to enclose word in tags. End up inside << or after >>
"e.g.   table|<<    ->    <table>|</table>
"       table|>>    ->    <table></table>|
inoremap <localleader>< <esc>bce<<c-r>"></<c-r>"><c-o>F<
inoremap <localleader>< <esc>bce<<c-r>"></<c-r>">
inoremap << <esc>bce<<c-r>"></<c-r>"><c-o>F<
inoremap >> <esc>bce<<c-r>"></<c-r>">

set colorcolumn=110
