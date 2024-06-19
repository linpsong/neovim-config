local Plugin = {
  {
    -- cmd = "Git",
    event = "VeryLazy",
    'tpope/vim-fugitive',
    config = function()
      -- convert `Git` to 'git' in the command line
      vim.cmd.cnoreabbrev([[git Git]])
      vim.cmd.cnoreabbrev([[gp Git push]])
    end
  },

  { -- usage: select the code and the GBrowse
    event = "VeryLazy",
    'tpope/vim-rhubarb',
  },

}

return Plugin
