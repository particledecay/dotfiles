" for Conventional Commits

inoreabbrev <buffer> BB BREAKING CHANGE:
nnoremap    <buffer> i  i<C-r>=<sid>commit_type()<CR>

fun! s:commit_type()
  call complete(1, ['fix: ', 'feat: ', 'refactor: ', 'docs: ', 'test: ', 'chore: ', 'build: ', 'ci: ', 'perf: ', 'style: ', 'revert: '])
  nunmap <buffer> i
  return ''
endfun
