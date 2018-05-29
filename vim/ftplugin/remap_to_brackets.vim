"å¨ is annoying
imap å [
imap ¨ ]
imap Å {
imap ^ }

cnoremap å [
cnoremap ¨ ]
cnoremap Å {
cnoremap ^ }
cnoremap zå å
cnoremap zÅ Å
cnoremap z^ ^

inoremap zå å
inoremap z¨ ¨
inoremap zÅ Å
inoremap zÅ Å
inoremap z^ ^

"fF operators
map få f[
map f¨ f]
map Få F[
map F¨ F]

map fÅ f{
map f^ f}
map FÅ F{
map F^ F}

"tT operators
map tå f[
map t¨ f]
map Tå F[
map T¨ F]

map tÅ f{
map t^ f}
map TÅ F{
map T^ F}

map rå r[
map r¨ r]
map rÅ r{
map r^ r}

"deletion with di, da
nmap daå da[
nmap da¨ da]
nmap daÅ da{
nmap da^ da}

nmap diå di[
nmap di¨ di]
nmap diÅ di{
nmap di^ di}

"deletion with df, dF, dt, dT
nmap dfå df[
nmap df¨ df]
nmap dfÅ df{
nmap df^ df}

nmap dFå dF[
nmap dF¨ dF]
nmap dFÅ dF{
nmap dF^ dF}

nmap dtå dt[
nmap dt¨ dt]
nmap dtÅ dt{
nmap dt^ dt}

nmap dTå dT[
nmap dT¨ dT]
nmap dTÅ dT{
nmap dT^ dT}

"change with ci, ca
nmap caå ca[
nmap ca¨ ca]
nmap caÅ ca{
nmap ca^ ca}

nmap ciå ci[
nmap ci¨ ci]
nmap ciÅ ci{
nmap ci^ ci}

"visual with vi, va
nmap vaå va[
nmap va¨ va]
nmap vaÅ va{
nmap va^ va}

nmap viå vi[
nmap vi¨ vi]
nmap viÅ vi{
nmap vi^ vi}

vmap aå a[
vmap a¨ a]
vmap aÅ a{
vmap a^ a}

vmap iå i[
vmap i¨ i]
vmap iÅ i{
vmap i^ i}

"change with cf, cF, ct, cT
nmap cfå cf[
nmap cf¨ cf]
nmap cfÅ cf{
nmap cf^ cf}

nmap cFå cF[
nmap cF¨ cF]
nmap cFÅ cF{
nmap cF^ cF}

nmap ctå ct[
nmap ct¨ ct]
nmap ctÅ ct{
nmap ct^ ct}

nmap cTå cT[
nmap cT¨ cT]
nmap cTÅ cT{
nmap cT^ cT}

nmap <iå <i[
nmap <i¨ <i]
nmap <iÅ <i{
nmap <i^ <i}

nmap >iå >i[
nmap >i¨ >i]
nmap >iÅ >i{
nmap >i^ >i}

"vim-surround
nmap dså ds[
nmap ds¨ ds]
nmap dsÅ ds{
nmap ds^ ds}

" Found at https://gist.github.com/kshenoy/00497c02590444fda6f5c85a43c3f8cb

function! ParJump(dir, ...)
  " Description: Paragraph jumping to land on non-blank lines
  " Arguments:
  "   dir = 1 : Search forward  for the last  line of the current paragraph or first line of the next one
  "         0 : Search backward for the first line of the current paragraph or last  line of the next one
  "   a:1     : Output of visualmode()
  " TODO:
  " * Cursor doesn't stay in the same column in Visual mode

  let l:curr_line = line('.')
  let l:curr_col  = col('.')

  if (a:dir)
    if (  (len(getline(l:curr_line)) == 0)
     \ || (len(getline(l:curr_line + 1)) == 0)
     \ )
      " Current or next line is blank
      " ==> Find next non-blank line
      let l:targ_line = nextnonblank(l:curr_line + 1)
    else
      " Neither the current nor the next line is blank i.e. we're in the middle of a paragraph
      " ==> Jump to the last non-blank line
      let l:targ_line = search('^$', 'nW')
      let l:targ_line = (l:targ_line > 0 ? l:targ_line - 1 : line('$'))
    endif
  else
    if (  (len(getline(l:curr_line)) == 0)
     \ || (len(getline(l:curr_line - 1)) == 0)
     \ )
      let l:targ_line = prevnonblank(l:curr_line - 1)
    else
      let l:targ_line = search('^$', 'nWb')
      let l:targ_line = (l:targ_line > 0 ? l:targ_line + 1 : 1)
    endif
  endif

  call setpos((a:0 ? "'>" : "."), [0, l:targ_line, l:curr_col])
  if a:0
    normal! gv
  endif
endfunction


nnoremap <silent> Å :call ParJump(0)<CR>
nnoremap <silent> ^ :call ParJump(1)<CR>
vnoremap <silent> Å :call ParJump(0, visualmode())<CR>
vnoremap <silent> ^ :call ParJump(1, visualmode())<CR>
