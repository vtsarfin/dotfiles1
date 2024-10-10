local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use { 'tpope/vim-fugitive' }
  use { "junegunn/fzf", run = "./install --bin" }
  use { "ibhagwan/fzf-lua",
  -- optional for icon support
  requires = { "nvim-tree/nvim-web-devicons" },
  config=function()
  require("fzf-lua").setup({ "fzf-vim" })
end,
  }
  use "nvim-lua/plenary.nvim"
  use { "TimUntersberger/neogit",
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
}
  use {"sindrets/diffview.nvim",
    config = function ()
      require("diffview").setup({
        view = {
          default = {
          --   layout = "diff2_horizontal_ba",
          },
        },
      }
      )
    end
  }
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({})
    end, }
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'mitchellh/tree-sitter-hcl',
    },
    config = function()
      require("configs.treesitter")
    end,
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use {
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
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  --  For vsnip users.
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use { "ellisonleao/glow.nvim", config = function() require("glow").setup() end }
  use 'hashivim/vim-terraform'
  -- Setup nvim-cmp.
  local cmp = require 'cmp'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = function(fallback)
        if not cmp.select_next_item() then
          if vim.bo.buftype ~= 'prompt' and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,

      ['<S-Tab>'] = function(fallback)
        if not cmp.select_prev_item() then
          if vim.bo.buftype ~= 'prompt' and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end,
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require'lspconfig'.bashls.setup{}
  require 'lspconfig'.perlpls.setup {}
  require 'lspconfig'.lua_ls.setup {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }
  require 'lspconfig'.yamlls.setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
      yaml = {
        schemaStore = {
          url = "https://www.schemastore.org/api/json/catalog.json",
          enable = true,
        },
        validate = true,
        format = { enable = true },
        hover = true,
        schemas = require("configs.schemas"),
      }
    }
  }
  -- vim.lsp.set_log_level("debug")
  require 'lspconfig'.terraformls.setup {
    cmd = { "terraform-ls", "serve", "-log-file /dev/null" }
  }
  vim.cmd([[let g:terraform_fmt_on_save=1]])
  vim.cmd([[let g:terraform_align=1]])
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.tf", "*.tfvars" },
    callback = function()
      vim.lsp.buf.format()
    end,
  })
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
end

)
