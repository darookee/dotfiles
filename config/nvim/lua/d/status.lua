local D

D = {
    setup = function()
        require 'heirline'.setup { statusline = require 'd.heirline'.statusline }
    end
}

return D
