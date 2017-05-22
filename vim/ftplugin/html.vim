"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

set colorcolumn=110

" OLD
"Type << or >> to enclose word in tags. End up inside << or after >>
"e.g.   table|<<    ->    <table>|</table>
"       table|>>    ->    <table></table>|
"inoremap >< ><<esc>F<"lyi<A<c-r>l><esc>F>a


inoremap ><< ><<esc>F<"lyi<f<a/<c-r>l><esc>F>a
inoremap >§§ ><<esc>F<"lyi<f<a/<c-r>l><esc>F>a

