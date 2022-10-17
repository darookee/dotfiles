return {
    options = function()
        wo.number = true
        wo.relativenumber = true
        opt.termguicolors = true
        opt.cursorline = true

        opt.undodir = "undo"
        opt.undofile = true
        opt.swapfile = false

        opt.scrolloff = 5
        opt.list = true
        opt.listchars = {
            tab = "»·",
            eol = "↲",
            nbsp = "␣",
            extends = "…"
        }

        opt.ignorecase = true
        opt.smartcase = true

        opt.expandtab = true
        opt.shiftwidth = 4
        opt.tabstop = 4

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
    end,

    keymaps = function()
        local _utils = require('utils')
        local keymap = _utils.keymap

        vim.g.mapleader = '_'
        opt.pastetoggle = "<F10>"

        keymap('<space>', 'za')
        keymap('%%', '<C-R>=expand("%:h")."/"<CR>', 'c')
        keymap('<leader>=', ':!column -t -o" "<CR>gv=', 'v')
        keymap('gp', '`[".strpart(getregtype(), 0, 1)."`]')
        keymap('<C-h>', '<C-w>h')
        keymap('<C-k>', '<C-w>k')
        keymap('<C-l>', '<C-w>l')
        keymap('<C-j>', '<C-w>j')

        keymap('<leader>pq', function() package.loaded.plugins = nil require('plugins').sync_all() end)

        -- custom textobjects
        local objects = { "_", ".", ":", ",", ";", "<bar>", "/", "<bslash>", "*", "+", "%", "`" }
        for _, object in ipairs(objects) do
            keymap('i'..object, ':<C-u>normal! T'..object..'vt'..object..'<CR>', 'x')
            keymap('i'..object, ':normal! vi'..object..'<CR>', 'o')
            keymap('a'..object, ':<C-u>normal! F'..object..'vf'..object..'<CR>', 'x')
            keymap('a'..object, ':normal! va'..object..'<CR>', 'o')
        end
    end,
}
