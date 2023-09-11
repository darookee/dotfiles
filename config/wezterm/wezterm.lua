local wezterm = require 'wezterm'

-- use tmux status in top right status bar
wezterm.on("update-right-status", function(window)
    local _, stdout, stderr = wezterm.run_child_process { '/usr/bin/bash', '-c', '~/.bin/tmux_status_noconky' }

    if stderr ~= nil or stderr ~= '' then
        wezterm.log_error(stderr)
    end

    window:set_right_status(stdout)

    local leader = "   "
    if window:leader_is_active() then
        leader = " L "
    end

    window:set_left_status(leader)
end)

-- maximize window on startup
wezterm.on("gui-startup", function()
    local _, _, window = wezterm.mux.spawn_window {}

    window:gui_window():maximize()
end)

return {
    term = "wezterm",
    default_cursor_style = 'BlinkingUnderline',
    cursor_blink_ease_in = 'EaseIn',
    cursor_blink_ease_out = 'EaseOut',
    cursor_thickness = 1,
    cursor_blink_rate = 600,
    -- window_decorations = 'NONE',
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    show_new_tab_button_in_tab_bar = false,
    tab_bar_at_bottom = true,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    warn_about_missing_glyphs = false,
    allow_square_glyphs_to_overflow_width = 'Always',
    font_size = 8,
    font = wezterm.font('CascadiaCode', { weight = 'Regular', stretch = 'Normal' }),
    font_rules = {
        {
            intensity = 'Bold',
            italic = true,
            font = wezterm.font {
                family = 'CascadiaCode',
                weight = 'Bold',
                style = 'Italic',
            },
        },
        {
            intensity = 'Bold',
            italic = false,
            font = wezterm.font {
                family = 'CascadiaCode',
                weight = 'Bold',
                style = 'Normal',
            },
        },
        {
            intensity = 'Normal',
            italic = true,
            font = wezterm.font {
                family = 'CascadiaCode',
                weight = 'Regular',
                style = 'Italic',
            },
        },
    },

    window_background_opacity = 0.8,

    inactive_pane_hsb = {
        brightness = 0.5,
        saturation = 0.6,
    },

    -- colors
    color_scheme = 'Kaolin Dark',
    color_schemes = {
        ['Kaolin Dark'] = {
            foreground = '#E4E4E8',
            background = '#18181B',
            selection_fg = '#18181B',
            selection_bg = '#E4E4E8',

            cursor_bg = '#E4E4E8',
            cursor_fg = '#ffffff',

            split = '#4D9391',

            ansi = {
                '#4B5254',
                '#CD5C60',
                '#6FB593',
                '#DBAC66',
                '#91B9C7',
                '#845A84',
                '#4D9391',
                '#E4E4E8',
            },
            brights = {
                '#879193',
                '#E36D5B',
                '#72CCBA',
                '#F2C866',
                '#97B8DE',
                '#8C629C',
                '#5096AB',
                '#EFEFF1',
            },
        },
    },

    -- mimic tmux keybindings using leader
    leader = { key = 'b', mods = 'CTRL' },
    keys = {
        -- send leader to tmux
        {
            key = 'b',
            mods = 'LEADER|CTRL',
            action = wezterm.action.SendKey { key = 'b', mods = 'CTRL' },
        },
        -- select pane and tab
        {
            key = 's',
            mods = 'SHIFT|CTRL',
            action = wezterm.action.PaneSelect {
                alphabet = '1234567890',
            },
        },
        {
            key = 's',
            mods = 'LEADER',
            action = wezterm.action.ShowTabNavigator,
        },
        -- zoom
        {
            key = 'z',
            mods = 'LEADER',
            action = wezterm.action.TogglePaneZoomState,
        },
        -- tabs
        {
            key = "c",
            mods = "LEADER|SHIFT",
            action = wezterm.action.SpawnCommandInNewWindow {
                cwd = "~"
            },
        },
        {
            key = "c",
            mods = "LEADER",
            action = wezterm.action.SpawnCommandInNewTab {
                cwd = "~"
            },
        },
        -- splits
        {
            key = "-",
            mods = "LEADER",
            action = wezterm.action.SplitVertical {
                domain = 'CurrentPaneDomain'
            },
        },
        {
            key = "|",
            mods = "LEADER",
            action = wezterm.action.SplitHorizontal {
                domain = 'CurrentPaneDomain'
            },
        },
        -- move active pane
        {
            key = 'h',
            mods = 'LEADER',
            action = wezterm.action.ActivatePaneDirection 'Left',
        },
        {
            key = 'l',
            mods = 'LEADER',
            action = wezterm.action.ActivatePaneDirection 'Right',
        },
        {
            key = 'k',
            mods = 'LEADER',
            action = wezterm.action.ActivatePaneDirection 'Prev',
        },
        {
            key = 'j',
            mods = 'LEADER',
            action = wezterm.action.ActivatePaneDirection 'Next',
        },
        -- resize panes
        {
            key = 'H',
            mods = 'LEADER',
            action = wezterm.action.ActivateKeyTable {
                name = 'resize_panes',
                one_shot = false,
                timeout_milliseconds = 750,
            },
        },
        {
            key = 'J',
            mods = 'LEADER',
            action = wezterm.action.ActivateKeyTable {
                name = 'resize_panes',
                one_shot = false,
                timeout_milliseconds = 750,
            },
        },
        {
            key = 'K',
            mods = 'LEADER',
            action = wezterm.action.ActivateKeyTable {
                name = 'resize_panes',
                one_shot = false,
                timeout_milliseconds = 750,
            },
        },
        {
            key = 'L',
            mods = 'LEADER',
            action = wezterm.action.ActivateKeyTable {
                name = 'resize_panes',
                one_shot = false,
                timeout_milliseconds = 750,
            },
        },
        -- close panes
        {
            key = 'x',
            mods = 'LEADER',
            action = wezterm.action.CloseCurrentPane { confirm = true },
        },
        {
            key = 'X',
            mods = 'LEADER',
            action = wezterm.action.CloseCurrentTab { confirm = true },
        },
        {
            key = 'p',
            mods = 'LEADER',
            action = wezterm.action.ActivateTabRelative(-1)
        },
        {
            key = 'n',
            mods = 'LEADER',
            action = wezterm.action.ActivateTabRelative(1)
        },
        -- cycle-move panes
        {
            key = '[',
            mods = 'LEADER',
            action = wezterm.action.RotatePanes 'CounterClockwise',
        },
        {
            key = ']',
            mods = 'LEADER',
            action = wezterm.action.RotatePanes 'Clockwise',
        },
    },
    key_tables = {
        resize_panes = {
            -- resize panes
            {
                key = 'H',
                mods = 'SHIFT',
                action = wezterm.action.AdjustPaneSize { 'Left', 5 },
            },
            {
                key = 'J',
                mods = 'SHIFT',
                action = wezterm.action.AdjustPaneSize { 'Down', 5 },
            },
            {
                key = 'K',
                mods = 'SHIFT',
                action = wezterm.action.AdjustPaneSize { 'Up', 5 }
            },
            {
                key = 'L',
                mods = 'SHIFT',
                action = wezterm.action.AdjustPaneSize { 'Right', 5 },
            },
        },
        cycle_panes = {
            {
                key = 'h',
                action = wezterm.action.ActivatePaneDirection 'Left',
            },
            {
                key = 'l',
                action = wezterm.action.ActivatePaneDirection 'Right',
            },
            {
                key = 'k',
                action = wezterm.action.ActivatePaneDirection 'Prev',
            },
            {
                key = 'j',
                action = wezterm.action.ActivatePaneDirection 'Next',
            },
        },
    },
}
