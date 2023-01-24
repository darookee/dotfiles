local fn = vim.fn
local cmd = vim.cmd

local plugins = {
    -- paq
    "savq/paq-nvim"; -- Let Paq manage itself
    "lewis6991/impatient.nvim";

    -- tools
    -- "Darazaki/indent-o-matic";

    "neovim/nvim-lspconfig";
    { "ray-x/lsp_signature.nvim", after = "nvim-lspconfig" };
    { "mfussenegger/nvim-jdtls", after = "nvim-lspconfig" };
    "jose-elias-alvarez/null-ls.nvim";
    "j-hui/fidget.nvim";

    -- dependencies
    "nvim-lua/popup.nvim";
    "nvim-lua/plenary.nvim";

    -- telescope
    { "nvim-telescope/telescope.nvim", branch = "0.1.x" };
    { "nvim-telescope/telescope-media-files.nvim", after = "telescope.nvim" };
    { "cljoly/telescope-repo.nvim", after = "telescope.nvim" };
    { "nvim-telescope/telescope-file-browser.nvim", after = "telescope.nvim" };
    { "nvim-telescope/telescope-fzf-native.nvim", after = "telescope.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" };

    -- { "nvim-telescope/telescope-ui-select.nvim", after="telescope.nvim" };
    -- "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify";
    -- { "folke/noice.nvim", after="MunifTanjim/nui.nvim" },

    -- parenthesis highlighting
    -- { "p00f/nvim-ts-rainbow", after="nvim-treesitter" };
    -- Autoclose tags
    { "windwp/nvim-ts-autotag", after = "nvim-treesitter" };
    -- { "m-demare/hlargs.nvim", after="nvim-treesitter" };
    -- Context based commenting
    -- { "JoosepAlviste/nvim-ts-context-commentstring", after="nvim-treesitter" };
    { "nvim-treesitter/playground", after = "nvim-treesitter" };
    -- Syntax highlighting
    { "nvim-treesitter/nvim-treesitter", run = function() cmd 'TSUpdate' end };

    -- Autopairs
    "windwp/nvim-autopairs";

    -- Comments
    "numToStr/Comment.nvim";

    -- Ansible
    "pearofducks/ansible-vim";
    "b4b4r07/vim-ansible-vault";

    -- 'sandwich'
    "machakann/vim-sandwich";

    -- reverse J
    -- "AckslD/nvim-trevJ.lua";

    -- colors
    -- "norcalli/nvim-colorizer.lua";

    -- git
    "lewis6991/gitsigns.nvim";

    -- filetypes
    "nelsyeung/twig.vim";
    -- "lumiliet/vim-twig";
    "gbprod/php-enhanced-treesitter.nvim";

    -- whitespace
    { "lewis6991/spaceless.nvim", pin = true };

    -- wildmenu
    "gelguy/wilder.nvim";

    -- statusline
    "rebelot/heirline.nvim";

    -- visuals
    "kyazdani42/nvim-web-devicons";
    "lukas-reineke/indent-blankline.nvim";
    "max397574/better-escape.nvim";
    "yamatsum/nvim-cursorline";
    "melkster/modicator.nvim";
    "lcheylus/overlength.nvim";
    "petertriho/nvim-scrollbar";
    -- "sunjon/shade.nvim";
    -- "folke/twilight.nvim";

    -- textobjects
    "kana/vim-textobj-user";
    "Julian/vim-textobj-variable-segment";
    "tpope/vim-speeddating";

    -- snippets
    "L3MON4D3/LuaSnip";

    -- cmp
    { "hrsh7th/nvim-cmp", after = "L3MON4D3/LuaSnip" };
    { "saadparwaiz1/cmp_luasnip", after = "L3MON4D3/LuaSnip" };
    { "hrsh7th/cmp-nvim-lsp", after = "hrsh7th/nvim-cmp" };
    { "hrsh7th/cmp-buffer", after = "hrsh7th/nvim-cmp" };
    { "hrsh7th/cmp-path", after = "hrsh7th/nvim-cmp" };
    { "hrsh7th/cmp-cmdline", after = "hrsh7th/nvim-cmp" };
    { "onsails/lspkind.nvim", after = "hrsh7th/nvim-cmp" };

    -- themes
    -- "EdenEast/nightfox.nvim";
    "rktjmp/lush.nvim";
    "mcchrish/zenbones.nvim";
    -- "talha-akram/noctis.nvim";
    -- "navarasu/onedark.nvim";
    -- "JoosepAlviste/palenightfall.nvim";

}

local function clone_paq()
    local path = fn.stdpath 'data' .. '/site/pack/paqs/start/paq-nvim'
    if fn.empty(fn.glob(path)) > 0 then
        fn.system {
            'git',
            'clone',
            '--depth=1',
            'https://github.com/savq/paq-nvim.git',
            path,
        }
    end
end

local function bootstrap()
    clone_paq()

    -- Load Paq
    cmd 'packadd paq-nvim'
    local paq = require 'paq'

    -- Exit nvim after installing plugins
    cmd 'autocmd User PaqDoneInstall quit'

    -- Read and install packages
    paq(plugins):install()
end

local function sync_all()
    -- package.loaded.paq = nil
    (require 'paq')(plugins):sync()
end

return { bootstrap = bootstrap, sync_all = sync_all }
