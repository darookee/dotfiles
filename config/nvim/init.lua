setmetatable(_G, { __index = vim })

local _utils = require('utils')
local augroup = _utils.augroup
local keymap = _utils.keymap

local debug = env.NVIM_DEBUG ~= nil

do -- base config
    local basic = require('basic')

    basic.options()
    basic.keymaps()
end

do -- LSP & Diagnostics
    -- null-ls
    local nullls = require('null-ls')
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
                local phpcsconfigs = { "phpcs.xml.dist", "phpcs.xml", ".phpcs.xml.dist", ".phpcs.xml" }

                for _, file in ipairs(phpcsconfigs) do
                    if utils.root_has_file {file} or utils.root_has_file {'app/'..file} then
                        return true
                    end
                end
            end,
            prefer_local = "vendor/bin",
            cwd = function (params)
                return vim.loop.fs_stat(params.root.."/app") and params.root.."/app"
            end,
        },
        nullbuiltin.diagnostics.phpmd.with {
            condition = function (utils)
                return utils.root_has_file {'phpmd.xml'} or utils.root_has_file {'app/phpmd.xml'}
            end,
            extra_args = function (params)
                local nullutils = require('null-ls.utils').make_conditional_utils()

                return { params.cwd.."/phpmd.xml" }
            end,
            prefer_local = "vendor/bin",
            cwd = function (params)
                return vim.loop.fs_stat(params.root.."/app") and params.root.."/app"
            end,
        },
        nullbuiltin.diagnostics.phpstan.with {
            condition = function (utils)
                return utils.root_has_file {'phpstan.neon'} or utils.root_has_file {'app/phpstan.neon'}
            end,
            prefer_local = "vendor/bin",
            extra_args = { '--memory-limit=-1' },
            cwd = function (params)
                return vim.loop.fs_stat(params.root.."/app") and params.root.."/app"
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
        debug = debug,
        save_after_format = false,
        sources = nullsources,
    }

    -- fidget
    require('fidget').setup()
end

do -- Telescope
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local fb_actions = require('telescope').extensions.file_browser.actions

    telescope.setup {
        defaults = {
            layout_config = { prompt_position = 'top' },
            sorting_strategy = 'ascending',
        },
        extensions = {
            file_browser = {
                hijack_netrw = true,
                mappings = {
                    ["i"] = {
                        ["-"] = fb_actions.goto_parent_dir,
                    }
                }
            },
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
    telescope.load_extension 'file_browser'

    keymap('<leader>/', builtin.current_buffer_fuzzy_find)
    keymap('<C-p>', builtin.find_files)
    keymap('K', builtin.grep_string)
    keymap('<leader><C-g>', builtin.live_grep)
    keymap('<leader><C-d>', builtin.diagnostics)
    keymap('<leader><C-k>', function() builtin.live_grep {grep_open_files = true} end)
    keymap('<leader><C-p>', builtin.buffers)
    keymap('<leader><C-m>', telescope.extensions.media_files.media_files)
    keymap('<leader><C-r>', telescope.extensions.repo.list)
    keymap('-', function() telescope.extensions.file_browser.file_browser { cwd = '%:h' } end)
end

do -- Tools
    require('impatient')



    require('Comment').setup()

    require('better_escape').setup {
        mapping = {"jk", "jj"},
        timeout = o.timeoutlen,
        clear_empty_lines = false
    }

    require('nvim-cursorline').setup {
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

    require('modicator').setup {
        cursorline = true,
    }

    require('indent_blankline').setup {
        show_current_context = true,
    }

    require('spaceless').setup()



    -- textobject-user
    opt.runtimepath:append('~/.local/share/nvim/site/pac/paqs/start/vim-textobj-user/')
    opt.runtimepath:append('~/.local/share/nvim/site/pac/paqs/start/vim-textobj-variable-segment/')

    -- ansible
    opt.runtimepath:append('~/.local/share/nvim/site/pac/paqs/start/ansible-vim/')
    opt.runtimepath:append('~/.local/share/nvim/site/pac/paqs/start/vim-ansible-vault/')

    -- sandwich
    opt.runtimepath:append('~/.local/share/nvim/site/pack/paqs/start/vim-sandwich/')
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
        "go",
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
    }

    require('nvim-autopairs').setup {
        check_ts = true
    }
end

do -- git
    require('gitsigns').setup {
        numhl = false,
        linehl = true,
        word_diff = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
            delay = 500,
            ignore_whitespace = true,
        },
        current_line_blame_formatter = '<author>, <abbrev_sha>, <author_time:%Y-%m-%d> - <summary>',
        on_attach = function (bufnr)
            local gs = package.loaded.gitsigns
            keymap('<leader>gb', function() gs.blame_line { full=true } end)
        end
    }
end

do -- Appearance
    cmd('colorscheme nightfox')

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
