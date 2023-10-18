-- [kristijanhusak/vim-carbon-now-sh]
vim.g.carbon_now_sh_options = {
  bg = 'rgba(123%252C182%252C221%252C0)',
  t = 'dracula-pro',
  wt = 'none',
  l = 'auto',
  ds = 'true',
  dsyoff = '14px',
  dsblur = '15px',
  wc = 'true',
  wa = 'true',
  pv = '44px',
  ph = '44px',
  ln = 'true',
  fm = 'MonoLisa',
  fs = '14.5px',
  lh = '142%252525',
  si = 'false',
  es = '2x',
  wm = 'false',
}
-- [kristijanhusak/vim-carbon-now-sh] use F12 for taking screenshots
vim.api.nvim_set_keymap('v', '<F12>', ':CarbonNowSh<CR>', { noremap = true })
