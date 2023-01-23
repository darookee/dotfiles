local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'

local api = vim.api
local fn = vim.fn
local bo = vim.bo

local lsp = vim.lsp
local diagnostic = vim.diagnostic

local highlightGroupMap = {

    scrollBar = "WarningMsg",

    fileName = "Title",
    fileFlags = "GitSignsAdd",
    fileReadonly = "GitSignsDelete",
    workDir = "Title",

    spell = "DiagnosticWarn",

    lspActive = "GitSignsAdd",

    diagWarn = "DiagnosticWarn",
    diagError = "DiagnosticError",
    diagHint = "DiagnosticHint",
    diagInfo = "DiagnosticInfo",

    git = "@text",
    gitAdd = "GitSignsAdd",
    gitChange = "GitSignsChange",
    gitDel = "GitSignsDelete",

    modeN = "Normal",
    modeI = "GitSignsAdd",
    modeV = "GitSignsChange",
    modeC = "@text",
    modeR = "GitSignsDelete",
    modeT = "Normal",
    modeS = "Normal",
}

local Align = { provider = "%=" }
local Space = { provider = " " }

local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
        self.filename = api.nvim_buf_get_name(0)
    end,
}

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require 'nvim-web-devicons'.get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon)
    end,

    hl = function(self)
        return { fg = self.icon_color }
    end,
}

local FileName = {
    init = function(self)
        self.lfilename = fn.fnamemodify(self.filename, ":.")
        if self.lfilename == "" then self.lfilename = "[No Name]" end
    end,

    hl = function()
        if bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = utils.get_highlight(highlightGroupMap.fileName).fg, bold = true, force = true }
        end
    end,

    { flexible = 2, {
        provider = function(self)
            return self.lfilename
        end,
    }, {
        provider = function(self)
            return fn.pathshorten(self.lfilename)
        end,
    } },
}

local FileFlags = {
    {
        provider = function()
            if bo.modified then
                return "[+]"
            else
                return "   "
            end
        end,
        hl = function()
            return { fg = utils.get_highlight(highlightGroupMap.fileFlags).fg }
        end,
    },
    {
        provider = function()
            if not bo.modifiable or bo.readonly then
                return ""
            else
                return " "
            end
        end,
        hl = function()
            return { fg = utils.get_highlight(highlightGroupMap.fileReadonly).fg }
        end
    },
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
    FileIcon, Space,
    FileName, Space,
    FileFlags,
    { provider = '%<' }
)

local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = function()
        return { fg = utils.get_highlight(highlightGroupMap.git).fg }
    end,

    { -- git branch name
        provider = function(self)
            return " " .. self.status_dict.head
        end,
        hl = { bold = true }
    },
    -- You could handle delimiters, icons and counts similar to Diagnostics
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = "("
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count)
        end,
        hl = function()
            return { fg = utils.get_highlight(highlightGroupMap.gitAdd).fg }
        end,
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count)
        end,
        hl = function()
            return { fg = utils.get_highlight(highlightGroupMap.gitDel).fg }
        end,
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("~" .. count)
        end,
        hl = function()
            return { fg = utils.get_highlight(highlightGroupMap.gitChange).fg }
        end,
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ")",
    },
}

local FileType = {
    provider = function()
        return string.upper(bo.filetype)
    end,

    hl = function(self)
        local color = self:mode_color()

        return { fg = color, bold = true }
    end,
}

local FileEncoding = {
    provider = function()
        local enc = (bo.fenc ~= '' and bo.fenc) or vim.o.enc -- :h 'enc'
        return enc ~= 'utf-8' and enc:upper()
    end
}

local FileFormat = {
    provider = function()
        local fmt = bo.fileformat
        return fmt ~= 'unix' and fmt:upper()
    end
}

local FileSize = {
    provider = function()
        -- stackoverflow, compute human readable file size
        local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
        local fsize = fn.getfsize(api.nvim_buf_get_name(0))
        fsize = (fsize < 0 and 0) or fsize
        if fsize < 1024 then
            return fsize .. suffix[1]
        end
        local i = math.floor((math.log(fsize) / math.log(1024)))
        return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
    end
}

local FileLastModified = {
    -- did you know? Vim is full of functions!
    provider = function()
        local ftime = fn.getftime(api.nvim_buf_get_name(0))
        return (ftime > 0) and os.date("%c", ftime)
    end
}

local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = "%7(%l/%3L%):%2c",
}

local ScrollBar = {
    static = {
        sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
    },
    provider = function(self)
        local curr_line = api.nvim_win_get_cursor(0)[1]
        local lines = api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
    end,
    hl = function()
        return { fg = utils.get_highlight(highlightGroupMap.scrollBar).fg }
    end,
}

local LSPActive = {
    condition = conditions.lsp_attached,
    update = { 'LspAttach', 'LspDetach' },

    -- You can keep it simple,
    -- provider = " [LSP]",

    -- Or complicate things a bit and get the servers names
    provider = function()
        local names = {}
        for i, server in pairs(lsp.buf_get_clients(0)) do
            table.insert(names, server.name)
        end
        return " [" .. table.concat(names, " ") .. "]"
    end,
    hl       = function()
        return { fg = utils.get_highlight(highlightGroupMap.lspActive).fg, bold = true }
    end,
}

local Diagnostics = {

    condition = conditions.has_diagnostics,

    init = function(self)
        self.errors = #diagnostic.get(0, { severity = diagnostic.severity.ERROR })
        self.warnings = #diagnostic.get(0, { severity = diagnostic.severity.WARN })
        self.hints = #diagnostic.get(0, { severity = diagnostic.severity.HINT })
        self.info = #diagnostic.get(0, { severity = diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
        provider = " [",
    },
    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.errors .. " ")
        end,
        hl = function()
            return { fg = utils.get_highlight(highlightGroupMap.diagError).fg }
        end,
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warnings .. " ")
        end,
        hl = function()
            return { fg = utils.get_highlight(highlightGroupMap.diagWarn).fg }
        end,
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info .. " ")
        end,
        hl = function()
            return { fg = utils.get_highlight(highlightGroupMap.diagInfo).fg }
        end,
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hints)
        end,
        hl = function()
            return { fg = utils.get_highlight(highlightGroupMap.diagHint).fg }
        end,
    },
    {
        provider = "]",
    },
}

local WorkDir = {
    provider = function(self)
        self.icon = " "
        local cwd = fn.getcwd(0)
        self.cwd = fn.fnamemodify(cwd, ":~")
    end,
    hl = function()
        return { fg = utils.get_highlight(highlightGroupMap.workDir).fg, bold = true }
    end,

    { flexible = 1, {
        -- evaluates to the full-lenth path
        provider = function(self)
            local trail = self.cwd:sub(-1) == "/" and "" or "/"
            return self.icon .. self.cwd .. trail
        end,
    }, {
        -- evaluates to the shortened path
        provider = function(self)
            local cwd = fn.pathshorten(self.cwd)
            local trail = self.cwd:sub(-1) == "/" and "" or "/"
            return self.icon .. cwd .. trail
        end,
    }, {
        -- evaluates to "", hiding the component
        provider = "",
    } },
}

local Spell = {
    condition = function()
        return vim.wo.spell
    end,
    provider = 'SPELL ',
    hl = function()
        return { bold = true, fg = utils.get_highlight(highlightGroupMap.spell).fg }
    end,
}

local HelpFileName = {
    condition = function()
        return bo.filetype == "help"
    end,
    provider = function()
        local filename = api.nvim_buf_get_name(0)
        return fn.fnamemodify(filename, ":t")
    end,
    hl = function()
        return { fg = utils.get_highlight(highlightGroupMap.HelpFileName).fg }
    end,
}

local DefaultStatusline = {
    FileType, Space,
    FileNameBlock, Space,
    Ruler, Space, ScrollBar, Space,
    Align,
    LSPActive, Space, Diagnostics, Space,
    WorkDir, Space, Git
}

local InactiveStatusline = {
    condition = conditions.is_not_active,
    FileType, Space,
    FileNameBlock, Align,
}

local SpecialStatusline = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "^git.*", "fugitive" },
        })
    end,

    FileType, Space, HelpFileName, Align
}

local StatusLines = {

    hl = function()
        if conditions.is_active() then
            return "StatusLine"
        else
            return "StatusLineNC"
        end
    end,

    -- the first statusline with no condition, or which condition returns true is used.
    -- think of it as a switch case with breaks to stop fallthrough.
    fallthrough = false,

    SpecialStatusline, InactiveStatusline, DefaultStatusline,

    static = {
        mode_color = function()
            local mode = conditions.is_active() and fn.mode() or "n"
            local modeMap = {
                n = "N",
                i = "I",
                v = "V",
                V = "V",
                ["\22"] = "V",
                c = "C",
                s = "S",
                S = "S",
                ["\19"] = "S",
                R = "R",
                r = "R",
                ["!"] = "C",
                t = "T",
            }

            return utils.get_highlight(highlightGroupMap['mode' .. modeMap[mode]]).fg
        end,
    },
}

return {
    statusline = StatusLines
}
