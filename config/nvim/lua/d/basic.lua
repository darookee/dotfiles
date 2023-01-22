local notify = vim.notify
local fn = vim.fn
local wo = vim.wo
local opt = vim.opt
local o = vim.o
local g = vim.g
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local keymap = require'utils'.keymap
local augroup = require'utils'.augroup

-- options
wo.number = true
wo.relativenumber = true
opt.termguicolors = true
opt.cursorline = true

if fn.has('persistent_undo') then
    local target_path = fn.expand('~/.local/share/nvim/undo')
    if fn.isdirectory(target_path) < 1 then
        notify('Creating undo directory')
        fn.mkdir(target_path, 'p')
    end
    o.undodir = target_path
    opt.undofile = true
end
opt.swapfile = false

opt.scrolloff = 5
opt.list = true
opt.listchars = {
    tab = "»·",
    eol = "↲",
    nbsp = "␣",
    extends = "…"
}

opt.gdefault = true
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

opt.autoindent = true
opt.smartindent = true

opt.laststatus = 2

opt.mouse = ''

opt.wildignore = {
    "*.swp",
    "*.bak",
    "*.pyc",
    "*/.git/**/*",
    "*/vendor/*",
    "*/node_modules/*",
    "*.tar.*",
}

opt.foldopen = opt.foldopen + 'search'

opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

opt.secure = true

opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

-- keymaps
g.mapleader = '_'
opt.pastetoggle = "<F10>"

keymap('<space>', 'za')
keymap('%%', '<C-R>=expand("%:h")."/"<CR>', 'c')
keymap('<leader>=', ':!column -t -o" "<CR>gv=', 'v')
keymap('gp', "'`[' . strpart(getregtype(), 0, 1) . '`]'", 'n', { expr = true })
keymap('<C-h>', '<C-w>h')
keymap('<C-k>', '<C-w>k')
keymap('<C-l>', '<C-w>l')
keymap('<C-j>', '<C-w>j')

keymap('<leader>pq', function() package.loaded.plugins = nil require'd.plugins'.sync_all() end)

keymap('<leader>ff', function() lsp.buf.format(nil, 10000) end)
keymap('<leader>fc', function() lsp.buf.code_action() end)

-- remove trailing spaces
keymap(',W', ':%s/\\v\\s+$//e<CR>')

-- split line on cursor
keymap('S', ':s/\\(.\\{-}\\)\\(\\s*\\)\\(\\%#\\)\\(\\s*\\)\\(.*\\)/\\1\\r\\3\\5<CR>:nohl<CR>')

-- lsp
keymap('<leader>e', diagnostic.open_float)
keymap('<leader>d', diagnostic.goto_prev)
keymap('<leader>f', diagnostic.goto_next)
keymap('<leader>q', diagnostic.setloclist)

keymap('<leader>.=', function() lsp.buf.format { async = true } end)

-- keymap('<leader>gD', lsp.buf.declaration)
-- keymap('<leader>gd', lsp.buf.definition)
keymap('<leader><leader>', lsp.buf.hover)
-- keymap('<leader>gi', lsp.buf.implementation)

-- custom textobjects
local objects = { "_", ".", ":", ",", ";", "<bar>", "/", "<bslash>", "*", "+", "%", "`" }
for _, object in ipairs(objects) do
    keymap('i' .. object, ':<C-u>normal! T' .. object .. 'vt' .. object .. '<CR>', 'x')
    keymap('i' .. object, ':normal! vi' .. object .. '<CR>', 'o')
    keymap('a' .. object, ':<C-u>normal! F' .. object .. 'vf' .. object .. '<CR>', 'x')
    keymap('a' .. object, ':normal! va' .. object .. '<CR>', 'o')
end

-- reset position
augroup('reload', {
    BufReadPost = {
        command = 'if line("\'\\\"") > 1 && line("\'\\\"") <= line("$") | exe "normal! g\'\\\"zz" | endif'
    },
})
