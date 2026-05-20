-- Or with configuration
return {
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('github-theme').setup({
      -- ...
    })

    vim.cmd('colorscheme github_dark')
    vim.api.nvim_set_hl(0, 'Cursor', { fg = '#0d1117', bg = '#ffdf5d' })
    vim.api.nvim_set_hl(0, 'lCursor', { fg = '#0d1117', bg = '#ffdf5d' })
    vim.api.nvim_set_hl(0, 'TermCursor', { fg = '#0d1117', bg = '#ffdf5d' })
    vim.opt.guicursor = {
      'n-v-c:block-Cursor',
      'i-ci-ve:ver25-Cursor',
      'r-cr:hor20-Cursor',
      'o:hor50-Cursor',
      'a:blinkwait700-blinkoff400-blinkon250',
      'sm:block-Cursor',
    }
  end,
}
