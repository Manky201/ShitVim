require('plugins')
require('vimopt')
require('tree')
require('lualine').setup{
	theme = nord	
}
require('treesitter')
require('lspconfig-nvim')
require('telescopt-lol')
--require('buffer')
-- vim.o.termguicolors = true
-- vim.o.number = true
-- vim.o.colorscheme = material
vim.cmd 'colorscheme nord'
--vim.wo.fillchars = 'eob: '
--vim.cmd 'nnoremap <C-n> :NvimTreeToggle<CR>'
