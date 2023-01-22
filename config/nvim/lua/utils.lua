local api = vim.api
local keymap = vim.keymap
local tbl_extend = vim.tbl_extend

return {
    command = api.nvim_create_user_command,

    keymap = function(lhs, rhs, mode, opts)
        local options = { noremap = true }
        if opts then
            options = tbl_extend("force", options, opts)
        end

        keymap.set(mode or 'n', lhs, rhs, options)
    end,

    augroup = function(name, autocmds)
        local group = api.nvim_create_augroup(name, {})
        for event, cmd in pairs(autocmds) do
            cmd.group = group
            api.nvim_create_autocmd(event, cmd)
        end
    end,

    hilink = function(source, target)
        api.nvim_set_hl(0, source, { link = target })
    end,

    hiset = function(name, options)
        api.nvim_set_hl(0, name, options)
    end,
}
