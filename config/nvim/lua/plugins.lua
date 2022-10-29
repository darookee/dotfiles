local PKGS = {
    -- paq
    "savq/paq-nvim"; -- Let Paq manage itself
    "lewis6991/impatient.nvim";

    -- tools

    "jose-elias-alvarez/null-ls.nvim";
    "j-hui/fidget.nvim";

    -- dependencies
    "nvim-lua/popup.nvim";
    "nvim-lua/plenary.nvim";

    -- telescope
    { "nvim-telescope/telescope.nvim", branch= "0.1.x" };
    "nvim-telescope/telescope-media-files.nvim";
    "cljoly/telescope-repo.nvim";
    "nvim-telescope/telescope-file-browser.nvim";

    -- parenthesis highlighting
    -- Autoclose tags
    { "windwp/nvim-ts-autotag", after="nvim-treesitter" };
    -- Context based commenting
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

    -- git
    "lewis6991/gitsigns.nvim";

    -- whitespace
    "lewis6991/spaceless.nvim";

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

    -- textobjects
    "kana/vim-textobj-user";
    "Julian/vim-textobj-variable-segment";

    -- themes
    "EdenEast/nightfox.nvim";
}

local function clone_paq()
    local path = vim.fn.stdpath 'data' .. '/site/pack/paqs/start/paq-nvim'
    if vim.fn.empty(vim.fn.glob(path)) > 0 then
        vim.fn.system {
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
    vim.cmd 'packadd paq-nvim'
    local paq = require 'paq'

    -- Exit nvim after installing plugins
    vim.cmd 'autocmd User PaqDoneInstall quit'

    -- Read and install packages
    paq(PKGS):install()
end

local function sync_all()
    -- package.loaded.paq = nil
    (require 'paq')(PKGS):sync()
end

return { bootstrap = bootstrap, sync_all = sync_all }
