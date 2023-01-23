local D

local api = vim.api
local loop = vim.loop

-- TODO: fold?!
-- opt.foldmethod = 'expr'
-- opt.foldexpr = 'nvim_treesitter#foldexpr()'

local defaultConfig = {
    langs = {
        "dockerfile",
        "javascript",
        "markdown",
        "markdown_inline",
        "vim",
        "sql",
        'lua',
        "vue",
        "gitignore",
        "python",
        "bash",
        "php",
        "phpdoc",
        "regex",
        "json",
        "yaml",
        "twig",
        "html",
        "css",
        "scss",
    }
}

D = {
    setup = function(opts)
        local conf = {
            langs = vim.list_extend(defaultConfig.langs, opts.langs),
        }

        require('nvim-treesitter.configs').setup {
            ensure_installed = conf.langs,
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(loop.fs_stat, api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
            indent = {
                enable = true,
            },
            autotag = {
                enable = true,
            },
        }
    end
}

return D
