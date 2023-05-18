vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.backup = false;
vim.opt.ruler = true
vim.opt.colorcolumn = '79'
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.call('plug#begin', '~/.config/nvim/plugged')

local Plug = vim.fn['plug#']

Plug('freeo/vim-kalisi')

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

Plug('neovim/nvim-lspconfig')


vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { branch = '0.1.x' })


vim.call('plug#end')

vim.opt.background = 'dark'
vim.cmd('colorscheme kalisi')

vim.g.mapleader = ','

vim.keymap.set('n', '<leader>c', function() return vim.cmd('let @/ = ""') end)

local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup {
        settings = {
                ['rust-analyzer'] = {},
        },
}
--[[
lspconfig.ccls.setup {
        init_options = {
                compilationDatabaseDirectory = "build";
                index = {
                        threads = 0;
                };
                clang = {
                        excludeArgs = { "-frounding-math" } ;
                };
        }
}
--]]

vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        end
})


vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
vim.keymap.set('n', '<C-b>', builtin.buffers, {})
vim.keymap.set('n', '<C-h>', builtin.help_tags, {})

vim.keymap.set('n', '<leader>gt', function() return vim.cmd.vsp('term://zsh') end)
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'W', 'w')
vim.keymap.set('n', 'X', 'x')

-- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-k>"] = require('telescope.actions').move_selection_previous,
                ["<C-j>"] = require('telescope.actions').move_selection_next,
                ["<C-c>"] = require('telescope.actions').close,
            },
            n = {
                ["<C-c>"] = require('telescope.actions').close,
            },
        },
    },
})


