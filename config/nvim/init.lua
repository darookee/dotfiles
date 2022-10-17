setmetatable(_G, { __index = vim })

local _utils = require('utils')
local augroup = _utils.augroup
local keymap = _utils.keymap

do -- base config
    local basic = require('basic')

    basic.options()
    basic.keymaps()
end

do -- LSP & Diagnostics
    keymap('<leader>e', vim.diagnostic.open_float)
    keymap('<leader>d', vim.diagnostic.goto_prev)
    keymap('<leader>f', vim.diagnostic.goto_next)
    keymap('<leader>q', vim.diagnostic.setloclist)

    -- null-ls
    local nullls = require('null-ls')
    local nullutils = require('null-ls.utils')
    local nullbuiltin = require('null-ls.builtins')

    local nullsources = {
        -- code-actions
        nullbuiltin.code_actions.eslint,
        nullbuiltin.code_actions.gitsigns,

        -- diagnostics
        nullbuiltin.diagnostics.ansiblelint,
        nullbuiltin.diagnostics.eslint,
        nullbuiltin.diagnostics.hadolint,
        nullbuiltin.diagnostics.php,
        nullbuiltin.diagnostics.phpcs.with {
            condition = function (utils)
                return utils.root_has_file {'phpcs.xml.dist'} or utils.root_has_file {'app/phpcs.xml.dist'}
            end,
            extra_args = {
                "--standard=phpcs.xml.dist"
            },
            prefer_local = "vendor/bin",
            cwd = function (params)
                return vim.loop.fs_stat(params.root.."/app") and "app"
            end,
        },
        nullbuiltin.diagnostics.phpmd.with {
            condition = function (utils)
                return utils.root_has_file {'phpmd.xml'} or utils.root_has_file {'app/phpmd.xml'}
            end,
            extra_args = {
                "phpmd.xml"
            },
            prefer_local = "vendor/bin",
            cwd = function (params)
                return vim.loop.fs_stat(params.root.."/app") and "app"
            end,
        },
        nullbuiltin.diagnostics.phpstan.with {
            condition = function (utils)
                return utils.root_has_file {'phpstan.neon'} or utils.root_has_file {'app/phpstan.neon'}
            end,
            prefer_local = "vendor/bin",
            cwd = function (params)
                return vim.loop.fs_stat(params.root.."/app") and "app"
            end,
        },
        nullbuiltin.diagnostics.sqlfluff,
        nullbuiltin.diagnostics.stylelint,
        nullbuiltin.diagnostics.tidy,
        nullbuiltin.diagnostics.todo_comments,
        nullbuiltin.diagnostics.trail_space,
        nullbuiltin.diagnostics.twigcs,
        nullbuiltin.diagnostics.yamllint,
        nullbuiltin.diagnostics.zsh,

        -- formatting
        nullbuiltin.formatting.blade_formatter,
        nullbuiltin.formatting.eslint,
        nullbuiltin.formatting.fixjson,
        nullbuiltin.formatting.jq,
        nullbuiltin.formatting.phpcbf,
        nullbuiltin.formatting.shfmt,
        nullbuiltin.formatting.sqlfluff,
        nullbuiltin.formatting.stylelint,
        nullbuiltin.formatting.tidy,
        nullbuiltin.formatting.xmllint,
    }

    nullls.setup {
        save_after_format = false,
        sources = nullsources,
    }

    -- fidget
    require('fidget').setup()
end

do -- Telescope
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'

    telescope.setup {
        defaults = {
            layout_config = { prompt_position = 'top' },
            sorting_strategy = 'ascending',
        },
        extensions = {
            repo = {
                list = {
                    search_dirs = {
                        "~/Dev",
                        "~/lib",
                    }
                }
            }
        }
    }

    telescope.load_extension 'media_files'
    telescope.load_extension 'repo'

    keymap('<leader>/', builtin.current_buffer_fuzzy_find)
    keymap('<C-p>', builtin.find_files)
    keymap('K', builtin.grep_string)
    keymap('<C-g>', builtin.live_grep)
    keymap('<leader><C-g>', function() builtin.live_grep({grep_open_files = true}) end)
    keymap('<leader><C-p>', builtin.buffers)
    keymap('<leader><C-m>', telescope.extensions.media_files.media_files)
    keymap('<leader><C-r>', telescope.extensions.repo.list)
end

do -- Tools
    require('impatient')

    require('indent-o-matic').setup {
        standard_widths = { 2, 4 },
    }

    -- require('trevj').setup {
    --     on_attach = function (bufnr)
    --         keymap('S', require('trevj').format_at_cursor)
    --     end
    -- }

    require('colorizer').setup()

    require('Comment').setup()

    require('better_escape').setup {
        mapping = {"jk", "jj"},
        timeout = vim.o.timeoutlen,
        clear_empty_lines = false
    }

    require('nvim-cursorline').setup {
        cursorline = {
            enable = true,
            timeout = 500,
            number = false,
        },
        cursorword = {
            enable = true,
            min_length = 3,
            hl = { underline = true },
        }
    }

    require('modicator').setup()

    require('indent_blankline').setup {
        show_current_context = true,
    }

    require('spaceless').setup()

    require('shade').setup()

    require('twilight').setup()

    opt.runtimepath:append('~/.local/share/nvim/site/pac/paqs/start/vim-textobj-user/')
    opt.runtimepath:append('~/.local/share/nvim/site/pac/paqs/start/vim-textobj-variable-segment/')
    opt.runtimepath:append('~/.local/share/nvim/site/pac/paqs/start/vim-ansible-vault/')
    opt.runtimepath:append('~/.local/share/nvim/site/pack/paqs/start/vim-sandwich/')
    opt.runtimepath:append('~/.local/share/nvim/site/pack/paqs/start/vim-dirvish/')
end

do -- wildmenu
    local wilder = require('wilder')

    wilder.setup {
        modes = {':', '/', '?'}
    }

    wilder.set_option('pipeline', {
        wilder.branch(

            wilder.python_file_finder_pipeline({
                file_command = {'fd', '-tf'},
                dir_command = {'fd', '-td'},
            }),

            wilder.substitute_pipeline({
                pipeline = wilder.python_search_pipeline({
                    skip_cmdtype_check = 1,
                    pattern = wilder.python_fuzzy_pattern({
                        start_at_boundary = 0,
                    }),
                }),
            }),

            wilder.cmdline_pipeline({
                fuzzy = 2,
            }),

            {
                wilder.check(function(ctx, x) return x == '' end),
                wilder.history(),
            },

            wilder.python_search_pipeline({
                pattern = wilder.python_fuzzy_pattern({
                    start_at_boundary = 0,
                }),
            })
        ),
    })

    local highlighters = {
        wilder.pcre2_highlighter(),
    }

    local popupmenu_renderer = wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
            border = 'rounded',
            empty_message = wilder.popupmenu_empty_message_with_spinner(),
            highlighter = highlighters,
            left = {
                ' ',
                wilder.popupmenu_devicons(),
                wilder.popupmenu_buffer_flags({
                    flags = ' a + ',
                    icons = {['+'] = '', a = '', h = ''},
                }),
            },
            right = {
                ' ',
                wilder.popupmenu_scrollbar(),
            },
        })
    )

    local wildmenu_renderer = wilder.wildmenu_renderer({
        highlighter = highlighters,
        separator = ' · ',
        left = {' ', wilder.wildmenu_spinner(), ' '},
        right = {' ', wilder.wildmenu_index()},
    })

    wilder.set_option('renderer', wilder.renderer_mux({
        [':'] = popupmenu_renderer,
        ['/'] = wildmenu_renderer,
        substitute = wildmenu_renderer,
    }))
end

do -- Treesitter
    -- TODO: fold?!
    -- opt.foldmethod = 'expr'
    -- opt.foldexpr = 'nvim_treesitter#foldexpr()'

    local langs = {
        "dockerfile",
        "javascript",
        "markdown",
        "markdown_inline",
        "lua",
        "vim",
        "sql",
        "vue",
        "gitignore",
        "python",
        "bash",
        "php",
        "phpdoc",
        "json",
        "yaml",
        "twig",
        "html",
        "css",
        "scss"
    }

    require('nvim-treesitter.configs').setup {
        ensure_installed = langs,
        highlight = {
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
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
        rainbow = {
            enable = true,
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
        },
        context_commentstring = {
            enable = true
        },
    }

    require('nvim-autopairs').setup {
        check_ts = true
    }
end

do -- git
    require('gitsigns').setup {
        numhl = true,
        linehl = false,
        word_diff = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        on_attach = function (bufnr)
            local gs = package.loaded.gitsigns
            keymap('<leader>gb', function() gs.blame_line{full=true} end)
        end
    }
end

do -- Appearance
    cmd('colorscheme duskfox')

    -- show trailing whitespace
    fn.matchadd('errorMsg', [[\s\+$]])

    require('overlength').setup {
        grace_length = 5,
        highlight_to_eol = false,
    }

    local line = require('heirline')
    line.load_colors(require('status').colors)
    line.setup(require('status').statusline)
end
