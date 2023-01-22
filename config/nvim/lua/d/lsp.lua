local D

local api = vim.api
local env = vim.env
local fn = vim.fn
local loop = vim.loop
local lsp = vim.lsp
local tbl_deep_extend = vim.tbl_deep_extend
local diagnostic = vim.diagnostic

local bind_keys = function()
    local keymap = require'utils'.keymap

    keymap('<leader>ff', function() lsp.buf.format(nil, 10000) end)
    keymap('<leader>fc', function() lsp.buf.code_action() end)

    keymap('<leader>e', diagnostic.open_float)
    keymap('<leader>d', diagnostic.goto_prev)
    keymap('<leader>f', diagnostic.goto_next)
    keymap('<leader>q', diagnostic.setloclist)

    keymap('<leader>.=', function() lsp.buf.format { async = true } end)

    -- keymap('<leader>gD', lsp.buf.declaration)
    -- keymap('<leader>gd', lsp.buf.definition)
    keymap('<leader><leader>', lsp.buf.hover)
    -- keymap('<leader>gi', lsp.buf.implementation)
end

local nullbuiltin = require'null-ls.builtins'

local defaultConfig = {
    nulllsServers = {
        -- code-actions
        nullbuiltin.code_actions.eslint,
        nullbuiltin.code_actions.gitsigns,

        -- diagnostics
        nullbuiltin.diagnostics.ansiblelint,
        nullbuiltin.diagnostics.eslint,
        nullbuiltin.diagnostics.hadolint,
        nullbuiltin.diagnostics.php,
        nullbuiltin.diagnostics.phpstan,
        nullbuiltin.diagnostics.phpmd,
        nullbuiltin.diagnostics.phpcs,
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
    },

    lspServers = {
        'bashls',
        'pyright',
        'html',
        'cssls',
        'tsserver',
        'jsonls',
        'dockerls',
        'ansiblels',
        'sumneko_lua',
        'marksman',
    }
}

-- null-ls
local lspconfig_on_attach = function(client, bufnr)
    require'lsp_signature'.on_attach {
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "rounded"
        },
        max_width = 120,
        wrap = false,
        floating_window_off_y = -1,
        auto_close_after = 10,
        hint_prefix = ' '
    }

    -- Enable completion triggered by <c-x><c-o>
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.lsp.omnifunc')

    if client.server_capabilities.documentHighlightProvider then
        api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
        api.nvim_create_autocmd("CursorHold", {
            callback = lsp.buf.document_highlight,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Document Highlight",
        })
        api.nvim_create_autocmd("CursorMoved", {
            callback = lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Clear All the References",
        })
    end
end

local lspconfig_root_dir = function()
    local cwd = fn.getcwd()

    if (loop.fs_stat(cwd.."/vendor")) then
        return cwd
    end

    if (loop.fs_stat(cwd.."/app")) then
        return cwd.."/app"
    end

    return cwd
end

local lspconfig_capabilities = require'cmp_nvim_lsp'.default_capabilities(lsp.protocol.make_client_capabilities())

local lspconfig = require'lspconfig'

D = {
    setup = function(opts)
        local debug = env.NVIM_DEBUG ~= nil
        local conf = tbl_deep_extend(
            'force',
            defaultConfig,
            opts
        )

        for _, lserver in ipairs(conf.lspServers) do
            lspconfig[lserver].setup {
                on_attach = lspconfig_on_attach,
                root_dir = lspconfig_root_dir,
                capabilities = lspconfig_capabilities,
                flags = {
                    debounce_text_changes = 150,
                }
            }
        end

        require'null-ls'.setup {
            debug = debug,
            save_after_format = false,
            sources = conf.nulllsServers,
        }

        -- fidget
        require'fidget'.setup {
            text = {
                spinner = "dots"
            }
        }

        bind_keys()
    end
}

return D
