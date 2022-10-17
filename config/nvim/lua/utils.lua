return {
    command = vim.api.nvim_create_user_command,

    keymap = function(lhs, rhs, mode, opts)
        local options = { noremap = true }
        if opts then
            options = vim.tbl_extend("force", options, opts)
        end

        vim.keymap.set(mode or 'n', lhs, rhs, options)
    end,

    augroup = function(name, autocmds)
        local group = vim.api.nvim_create_augroup(name, {})
        for event, cmd in pairs(autocmds) do
            cmd.group = group
            vim.api.nvim_create_autocmd(event, cmd)
        end
    end,
}
