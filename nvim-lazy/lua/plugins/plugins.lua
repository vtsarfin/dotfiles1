return {  
  { 'tpope/vim-fugitive' },
  { "junegunn/fzf", run = "./install --bin" },
  { "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config=function()
  require("fzf-lua").setup({ "fzf-vim" })
end,
  },
  {"nvim-lua/plenary.nvim"},
  { "TimUntersberger/neogit",
  config = function()
      require("neogit").setup({
   kind = "split", -- opens neogit in a split 
   signs = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
   },
   integrations = { diffview = true }, -- adds integration with diffview.nvim
  })
 end,
},
  {"sindrets/diffview.nvim"},
  { 'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
    config = function()
      require('lualine').setup({})
    end, },
 {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'mitchellh/tree-sitter-hcl',
    },
    config = function()
      require("config.treesitter")
    end,
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  },
  {
    'stevearc/conform.nvim',
    -- Set this value to true to silence errors when formatting a block fails
    -- require("conform.formatters.injected").options.ignore_errors = false
    config = function()
      require('conform').setup(
        {
                  -- format_on_save = {
          --   -- These options will be passed to conform.format()
          --   timeout_ms = 500,
          --   lsp_fallback = true,
          -- },
          formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            -- Use a sub-list to run only the first available formatter
            -- javascript = { { "prettierd", "prettier" } },
            yaml = { "yamlfix" },
            sh = { "beautysh" }
          },
          formatters = {
            -- yamllint = {
            --   -- command = "yamllint -c ~/.config/yamllint/config"
            -- },
            yamlfix = {
              command = "yamlfix",
              inherit = true,
              env = {
                YAMLFIX_preserve_quotes = "true",
                -- YAMLFIX_SEQUENCE_STYLE = "block_style"
              },
            },
            injected = {
              ignore_errors = false
            }
          }
        })
    end
  }
  -- use 'williamboman/nvim-lsp-installer'
 -- {"hrsh7th/cmp-nvim-lsp"},
--  {"hrsh7th/cmp-buffer"},
--  {"hrsh7th/cmp-path"},
--  {"hrsh7th/cmp-cmdline"},
--  {"hrsh7th/nvim-cmp"},
  --  For vsnip users.
--  {"hrsh7th/cmp-vsnip"},
--  {"hrsh7th/vim-vsnip"},
--  { "ellisonleao/glow.nvim", config = function() require("glow").setup() end },
--  {"hashivim/vim-terraform"},
  -- Setup nvim-cmp (left as marker).
-- closing
}
