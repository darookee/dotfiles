local env = vim.env
local cmd = vim.cmd
local fn = vim.fn

if not env.NEWCONFIG then
    cmd 'source ~/.config/nvim/old.init.vim'
end

if env.NEWCONFIG then
    -- install paq for nvim
    local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
    end

    require "paq" {
        "savq/paq-nvim";                  -- Let Paq manage itself

        -- "neovim/nvim-lspconfig";          -- Mind the semi-colons
        "hrsh7th/nvim-cmp";

        -- {"lervag/vimtex", opt=true};      -- Use braces when passing options
    }
end
