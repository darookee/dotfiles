local D

D = {
    setup = function()
        local api = vim.api
        local tbl_contains = vim.tbl_contains

        require 'nvim-autopairs'.setup {
            check_ts = true
        }

        local Rule = require 'nvim-autopairs.rule'
        local npairs = require 'nvim-autopairs'
        local cond = require 'nvim-autopairs.conds'
        local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

        require 'cmp'.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )

        local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' }, { '%', '%' } }
        npairs.add_rules {
            Rule(' ', ' ')
                :with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return tbl_contains({
                        brackets[1][1] .. brackets[1][2],
                        brackets[2][1] .. brackets[2][2],
                        brackets[3][1] .. brackets[3][2],
                        brackets[4][1] .. brackets[4][2]
                    }, pair)
                end)
                :with_move(cond.none())
                :with_cr(cond.none())
                :with_del(function(opts)
                    local col = api.nvim_win_get_cursor(0)[2]
                    local context = opts.line:sub(col - 1, col + 2)
                    return tbl_contains({
                        brackets[1][1] .. '  ' .. brackets[1][2],
                        brackets[2][1] .. '  ' .. brackets[2][2],
                        brackets[3][1] .. '  ' .. brackets[3][2],
                        brackets[4][1] .. '  ' .. brackets[4][2]
                    }, context)
                end),

            Rule('%', '%')
                :with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)

                    return tbl_contains({
                        brackets[3][1] .. brackets[3][2] -- this could be an '{' '}'
                    }, pair)
                end)
                :with_move(cond.none())
                :with_cr(cond.none()),
        }

        for _, bracket in pairs(brackets) do
            Rule('', ' ' .. bracket[2])
                :with_pair(cond.none())
                :with_move(function(opts) return opts.char == bracket[2] end)
                :with_cr(cond.none())
                :with_del(cond.none())
                :use_key(bracket[2])
        end

        for _, punct in pairs { ",", ";" } do
            require "nvim-autopairs".add_rules {
                require "nvim-autopairs.rule" ("", punct)
                    :with_move(function(opts) return opts.char == punct end)
                    :with_pair(function() return false end)
                    :with_del(function() return false end)
                    :with_cr(function() return false end)
                    :use_key(punct)
            }
        end

    end
}

return D
