local D

local cmd = vim.cmd
local fn = vim.fn
local highlight = vim.highlight

local augroup = require 'utils'.augroup
local hilink = require 'utils'.hilink
local hiset = require 'utils'.hiset

local update_cursorword_color = function()
    local utils = require('heirline.utils');
    local foldedColor = utils.get_highlight("Folded")
    local cursorWordHL = { underline = true }

    for k, v in pairs(foldedColor) do cursorWordHL[k] = v end

    hiset("CursorWord", cursorWordHL)
end

local link_highlights = function()
    hilink("GitSignsCurrentLineBlame", "@text.note")
    hilink("GitSignsAddInline", "@text.diff.add")
    hilink("GitSignsChangeInline", "DiagnosticSignWarn")
    hilink("GitSignsDeleteInline", "@text.strike")
end

local setup_augroup = function()
    augroup('highllights', {
        ColorScheme = {
            pattern = '*',
            callback = function()
                link_highlights()
                update_cursorword_color()
            end
        },
        VimEnter = {
            pattern = '*',
            callback = function()
                link_highlights()
                update_cursorword_color()
            end
        },
        TextYankPost = {
            callback = function()
                highlight.on_yank({ higroup = "IncSearch", timeout = "300" })
            end,
        },
    })
end

local colorscheme = function(scheme)
    cmd('colorscheme ' .. scheme)
end

D = {
    setup = function(opts)
        setup_augroup()

        colorscheme(opts.scheme)

        -- show trailing whitespace
        fn.matchadd('errorMsg', [[\s\+$]])
    end
}

return D
