local D

D = {
    setup = function(snippetPath)
        require'luasnip'
        require'luasnip.loaders.from_lua'.load({ paths = snippetPath })
    end
}

return D
