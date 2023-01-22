local D

local init_misc_plugins = function()
    local o = vim.o

    require'impatient'

    require'Comment'.setup()

    require'better_escape'.setup {
        mapping = {"jk", "jj"},
        timeout = o.timeoutlen,
        clear_empty_lines = false
    }

    require'nvim-cursorline'.setup {
        cursorline = {
            enable = false,
            timeout = 500,
            number = false,
        },

        cursorword = {
            enable = true,
            min_length = 3,
            hl = { underline = true },
        }
    }

    require'modicator'.setup {
        cursorline = true,
    }

    require'indent_blankline'.setup {
        show_current_context = true,
    }

    require'spaceless'.setup()

    require'scrollbar'.setup({
        handlers = {
            gitsigns = true,
        },
    })

    require'overlength'.setup {
        grace_length = 5,
        highlight_to_eol = false,
    }
end

local add_runtimepath = function()
    local opt = vim.opt

    -- textobject-user
    opt.runtimepath:append '~/.local/share/nvim/site/pac/paqs/start/vim-textobj-user/'
    opt.runtimepath:append '~/.local/share/nvim/site/pac/paqs/start/vim-textobj-variable-segment/'
    opt.runtimepath:append '~/.local/share/nvim/site/pac/paqs/start/vim-speeddating/'

    -- ansible
    opt.runtimepath:append '~/.local/share/nvim/site/pac/paqs/start/ansible-vim/'
    opt.runtimepath:append '~/.local/share/nvim/site/pac/paqs/start/vim-ansible-vault/'

    -- sandwich
    opt.runtimepath:append '~/.local/share/nvim/site/pack/paqs/start/vim-sandwich/'

    -- filetypes
    opt.runtimepath:append '~/.local/share/nvim/site/pack/paqs/start/twig.vim/'
end

D = {
    setup = function()
        init_misc_plugins()
        add_runtimepath()
    end
}

return D
