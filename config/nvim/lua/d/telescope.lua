local D

local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local fb_actions = require('telescope').extensions.file_browser.actions

local bind_keys = function()
    local keymap = require'utils'.keymap

    keymap('<leader><C-r>', builtin.resume)

    keymap('<C-p>', builtin.find_files)
    keymap('<leader><C-p>', builtin.buffers)

    keymap('<leader>/', builtin.current_buffer_fuzzy_find)
    keymap('K', builtin.grep_string)
    keymap('<leader><C-g>', builtin.live_grep)
    keymap('<leader><C-k>', function() builtin.live_grep {grep_open_files = true} end)


    keymap('<leader><C-d>', builtin.diagnostics)
    keymap('<leader><C-s>', builtin.lsp_references)
    keymap('<leader><C-a>', builtin.lsp_definitions)

    keymap('<leader>=', builtin.spell_suggest)

    -- TODO: these should probably only be loaded when the extension is enabled...?
    keymap('<leader><C-m>', telescope.extensions.media_files.media_files)
    keymap('-', function() telescope.extensions.file_browser.file_browser { path = vim.fn.expand('%:p:h') } end)
end

D = {
    setup = function(opts)
        telescope.setup {
            defaults = {
                prompt_prefix = '  ',
                layout_config = { prompt_position = 'top' },
                sorting_strategy = 'ascending',
                mappings = {
                    ["i"] = {
                       ["<esc>"] = "close",
                    },
                },
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
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
            }
        }

        for _, extension in ipairs(opts.extensions) do
            telescope.load_extension(extension)
        end

        bind_keys()
    end,

}

return D
