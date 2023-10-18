-- [airblade/vim-rooter] patterns for finding root directory
vim.g.rooter_patterns = {
  '>projects',
  '.git',
  '.github',
  'setup.py',
  'setup.cfg',
  'Makefile',
  'Taskfile',
  'go.mod',
  'package.json',
  'requirements.txt',
}
-- [airblade/vim-rooter] do not echo project directory
vim.g.rooter_silent_chdir = true
