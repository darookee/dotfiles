local D

D = {
    setup = function()
        local keymap = require'utils'.keymap

        require'gitsigns'.setup {
            numhl = false,
            linehl = true,
            word_diff = true,
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol',
                delay = 500,
                ignore_whitespace = true,
            },
            current_line_blame_formatter = ' <author>, <abbrev_sha>, <author_time:%Y-%m-%d> - <summary>',
            on_attach = function ()
                local gs = package.loaded.gitsigns
                keymap('<leader>gb', function() gs.blame_line { full=true } end)
            end
        }
    end
}

return D
