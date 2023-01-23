local D

D = {
    setup = function(conf)

        require'd.basic'.setup()
        require'd.colors'.setup(conf.colors)
        require'd.status'.setup()

        require'd.autopairs'.setup()
        require'd.gitsigns'.setup()

        require'd.tools'.setup()
        require'd.wilder'.setup()

        require'd.cmp'.setup()

        require'd.lsp'.setup(conf.lsp)

        require'd.luasnip'.setup(conf.luasnip)
        require'd.treesitter'.setup(conf.treesitter)
        require'd.telescope'.setup(conf.telescope)
    end
}

return D
