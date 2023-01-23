local D

local bind_keys = function()
    local keymap = require 'utils'.keymap
    local gs = package.loaded.gitsigns

    keymap('<leader>gb', function() gs.blame_line { full = true } end)
    keymap('<leader>gd', gs.toggle_deleted)
    keymap('<leader>gf', gs.diffthis)
end

D = {
    setup = function()
        require 'gitsigns'.setup {
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
            on_attach = bind_keys
        }
    end
}

return D
