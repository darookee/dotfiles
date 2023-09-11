-- helper functions
local nullDiagnostics = require 'null-ls.builtins'.diagnostics
local nullFormatting = require 'null-ls.builtins'.formatting
local nullUtils = require 'null-ls.utils'

local nulllscwd = function(params)
    return vim.loop.fs_stat(params.root .. "/app") and params.root .. "/app"
end

local nulllscondition = function(files)
    local utils = nullUtils.make_conditional_utils()

    for _, file in ipairs(files) do
        if utils.root_has_file { file } or utils.root_has_file { 'app/' .. file } then
            return true
        end
    end

    return false
end

local nulllsfileroot = function(files)
    local utils = nullUtils.make_conditional_utils()

    for _, file in ipairs(files) do
        if utils.root_has_file { file } then
            return { nullUtils.get_root() .. '/' .. file }
        end
        if utils.root_has_file { 'app/' .. file } then
            return { nullUtils.get_root() .. '/app/' .. file }
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
        lspServers = {
            'bashls',
            'pyright',
            'html',
            'eslint',
            'cssls',
            'jsonls',
            'dockerls',
            'ansiblels',
            'lua_ls',
            'marksman',
            'phpactor',
            'tsserver',
            'sqlls',
            'yamlls',
            'vimls',
            'openscad_ls',
            'gopls',
            'jdtls',
            'tflint',
            'terraformls'
        },
        disableNullls = false,
        nulllsServers = {
            -- diagnostics
            nullDiagnostics.hadolint,
            nullDiagnostics.phpcs.with {
                condition = function()
                    return nulllscondition { "phpcs.xml.dist", "phpcs.xml", ".phpcs.xml.dist", ".phpcs.xml" }
                end,
                prefer_local = "vendor/bin",
                cwd = nulllscwd,
            },
            nullDiagnostics.phpmd.with {
                condition = function()
                    return nulllscondition { "phpmd.xml", "phpmd.dist.xml" }
                end,
                extra_args = function()
                    return nulllsfileroot { "phpmd.xml", "phpmd.dist.xml" }
                end,
                prefer_local = "vendor/bin",
                cwd = nulllscwd,
            },
            nullDiagnostics.php,
            nullDiagnostics.stylelint,
            nullDiagnostics.tidy,
            nullDiagnostics.trail_space,
            nullDiagnostics.twigcs,
            nullDiagnostics.zsh,

            -- formatting
            nullFormatting.blade_formatter,
            nullFormatting.eslint,
            nullFormatting.fixjson,
            nullFormatting.jq,
            nullFormatting.phpcbf.with {
                condition = function()
                    return nulllscondition { "phpcs.xml.dist", "phpcs.xml", ".phpcs.xml.dist", ".phpcs.xml" }
                end,
                prefer_local = "vendor/bin",
                cwd = nulllscwd,
            },
            nullFormatting.shfmt,
            nullFormatting.stylelint,
            nullFormatting.tidy,
            nullFormatting.xmllint,
        },
        settings = {
            yamlls = {
                settings = {
                    yaml = {
                        schemas = {
                            ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '.gitlab-ci.yml',
                            ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yml',
                        }
                    },
                },
            },
            openscad_ls = {
                swttings = {
                    single_file_support = true,
                },
            },
            html = {
                filetypes = { "html", "html.twig", "html.twig.js", "html.twig.css", "html.twig.js.css", "smarty", "smarty.html" },
            },
        }
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
require 'd'.setup(config)
