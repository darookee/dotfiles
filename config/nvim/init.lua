local stat = vim.loop.fs_stat

-- helper functions
local nulllscwd = function(params)
    return stat(params.root.."/app") and params.root.."/app"
end

local nulllscondition = function(utils, files)
    for _, file in ipairs(files) do
        if utils.root_has_file {file} or utils.root_has_file {'app/'..file} then
            return true
        end
    end

    return false
end

-- config
local config = {
    colors = {
        scheme = 'neobones',
    },
    lsp = {
        lspServers = { 'phpactor', 'gopls', 'jdtls' },
        nulllsServers = {
            require'null-ls.builtins'.diagnostics.phpcs.with {
                condition = function (utils)
                    return nulllscondition(utils, { "phpcs.xml.dist", "phpcs.xml", ".phpcs.xml.dist", ".phpcs.xml" })
                end,
                prefer_local = "vendor/bin",
                cwd = nulllscwd,
            },
            require'null-ls.builtins'.diagnostics.phpmd.with {
                condition = function (utils)
                    return nulllscondition(utils, { "phpmd.xml" })
                end,
                extra_args = function (params)
                    return { params.cwd.."/phpmd.xml" }
                end,
                prefer_local = "vendor/bin",
                cwd = nulllscwd,
            },
            require'null-ls.builtins'.diagnostics.phpstan.with {
                condition = function (utils)
                    return nulllscondition(utils, { "phpstan.neon" })
                end,
                prefer_local = "vendor/bin",
                extra_args = { '--memory-limit=-1' },
                cwd = nulllscwd,
            },
        },
    },
    luasnip = {
        snippetPath = '~/.config/nvim/snippets'
    },
    treesitter = {
        langs = { "go", "vue" },
    },
    telescope = {
        extensions = {
            'media_files',
            'file_browser',
            'fzf',
        },
    },
}

-- setup
require'd'.setup(config)
