-- helper functions
local nulllscwd = function(params)
    return vim.loop.fs_stat(params.root .. "/app") and params.root .. "/app"
end

local nulllscondition = function(utils, files)
    for _, file in ipairs(files) do
        if utils.root_has_file { file } or utils.root_has_file { 'app/' .. file } then
            return true
        end
    end

    return false
end

local nullDiagnostics = require 'null-ls.builtins'.diagnostics
local nullFormatting = require 'null-ls.builtins'.formatting

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
            'cssls',
            'jsonls',
            'dockerls',
            'ansiblels',
            'sumneko_lua',
            'marksman',
            'phpactor',
            'tsserver',
            'sqlls',
            'yamlls',
            'vimls',
            'openscad_ls',
            'gopls',
            'jdtls',
        },
        disableNullls = false,
        nulllsServers = {
            -- diagnostics
            nullDiagnostics.hadolint,
            nullDiagnostics.phpcs.with {
                condition = function(utils)
                    return nulllscondition(utils, { "phpcs.xml.dist", "phpcs.xml", ".phpcs.xml.dist", ".phpcs.xml" })
                end,
                prefer_local = "vendor/bin",
                cwd = nulllscwd,
            },
            nullDiagnostics.phpmd.with {
                condition = function(utils)
                    return nulllscondition(utils, { "phpmd.xml" })
                end,
                extra_args = function(params)
                    return { params.cwd .. "/phpmd.xml" }
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
                condition = function(utils)
                    return nulllscondition(utils, { "phpcs.xml.dist", "phpcs.xml", ".phpcs.xml.dist", ".phpcs.xml" })
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
                yaml = {
                    schemas = {
                        ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '.gitlab-ci.yml',
                        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yml',
                    }
                }
            },
            openscad_ls = {
                single_file_support = true,
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
