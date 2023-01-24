local D

D = {
    setup = function()
        local api = vim.api

        local cmp = require 'cmp'

        cmp.setup({
            snippet = {
                expand = function(args)
                    require 'luasnip'.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            enabled = function()
                -- disable completion in comments
                local context = require 'cmp.config.context'
                -- keep command mode completion enabled when cursor is in a comment
                if api.nvim_get_mode().mode == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end,
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'buffer' },
                }
            ),
            formatting = {
                format = require 'lspkind'.cmp_format {
                    mode = 'symbol_text',
                    menu = ({
                        spell = "[Spell]",
                        buffer = "[Buffer]",
                        calc = "[Calc]",
                        emoji = "[Emoji]",
                        nvim_lsp = "[LSP]",
                        path = "[Path]",
                        look = "[Look]",
                        treesitter = "[treesitter]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[Latex]",
                        cmp_tabnine = "[Tab9]"
                    }),
                }
            }
        })

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
    end
}

return D
