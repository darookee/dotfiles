local D

D = {
    setup = function()
        local wilder = require 'wilder'

        wilder.setup {
            modes = { ':', '/', '?' }
        }

        wilder.set_option('pipeline', {
            wilder.branch(

                wilder.python_file_finder_pipeline({
                    file_command = { 'fd', '-tf' },
                    dir_command = { 'fd', '-td' },
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
                        icons = { ['+'] = '', a = '', h = '' },
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
            left = { ' ', wilder.wildmenu_spinner(), ' ' },
            right = { ' ', wilder.wildmenu_index() },
        })

        wilder.set_option('renderer', wilder.renderer_mux({
            [':'] = popupmenu_renderer,
            ['/'] = wildmenu_renderer,
            substitute = wildmenu_renderer,
        }))
    end
}

return D
