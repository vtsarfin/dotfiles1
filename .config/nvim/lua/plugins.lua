local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
require'lspconfig'.pyright.setup{}
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use { 'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
        require('lualine').setup()
    end, }
  -- Collection of configurations for built-in LSP client
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
end)
