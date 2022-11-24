
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local Split = require("nui.split")

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
vim.notify = 

require("sere.utils")
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event


Sere = function()


    Replace=""
    Pattern=""
    local self = {}


    function self.splitBuffer(cb)

        local split = Split({
            relative = "editor",
            position = "right",
            size = "40%",
        })

        -- mount/open the component

        -- unmount component when cursor leaves buffer
        --split:on(event.BufLeave, function()
        --split:unmount()
        --end)

        cb(split)
        --local t = getPodList()
        --vim.api.nvim_buf_set_keymap(split.bufnr, 'n', "s", ':lua Sere()._getPreview()' ,{})
        --vim.api.nvim_buf_set_keymap(split.bufnr, 'n', "m", ':lua Sere()._mark()<cr>' ,{})
        --vim.api.nvim_buf_set_keymap(split.bufnr, 'n', "R", ':lua Sere().replace(false)' ,{})
        --vim.api.nvim_buf_set_keymap(split.bufnr, 'n', "r", ':lua Sere().replace(true)' ,{})



        split:map("n", "p", function(bufnr)
            self.getPreview()
        end, { noremap = true })

        split:map("n", "R", function(bufnr)
            self.replace(false)
        end, { noremap = true })

        split:map("n", "r", function(bufnr)
            self.replace(true)
        end, { noremap = true })

        split:map("n", "U", function(bufnr)
            self.undo(false)
        end, { noremap = true })

        split:map("n", "u", function(bufnr)
            self.undo(true)
        end, { noremap = true })

        split:map("n", "m", function(bufnr)
            self.mark()
        end, { noremap = true })

        split:map("n", "gF", function(bufnr)
            vim.cmd(":vertical wincmd F")
        end, { noremap = true })


        split:mount()
    end

    function self.genLine()
        local length=vim.fn.col('$')-1
        local line = ''

        for i = 1, 10, 1 do
            line = line .. "_"
        end
        return line
    end

    function self.getPreview()
        local resultLine = vim.api.nvim_get_current_line()
        local curserPos = vim.api.nvim_win_get_cursor(0)
        local resultLineAsTable = self.split(resultLine, ":")

        local filepath = resultLineAsTable[1]
        local line = tonumber(resultLineAsTable[2])
        local linepos = tonumber(resultLineAsTable[3])
        local y
        local x
        if line < 5 then
            y = 1+10
            x = line
        else
            y = line+5
            x = line-5
        end

        local cmd2 = 'tail -n "+'..x..'" '..filepath..' | head -n "$(('..y..'-'..x..'+1))"'
        local cmdResult = cmdResult(cmd2)

        table.insert(cmdResult, 1, self.genLine())
        table.insert(cmdResult, self.genLine())

        local curPos=curserPos[1]
        local tilPos=curserPos[1]+13

        local curLeftPos=curserPos[1]
        local tilLeftPos=curserPos[1]+13
        local content =  vim.api.nvim_buf_get_lines(0, curLeftPos, 99999, false)
        vim.api.nvim_buf_set_lines(0, curPos, tilPos, false, cmdResult)

        vim.api.nvim_buf_set_lines(0, tilLeftPos, 99999, false, content)
    end

    function self.mark()
        vim.cmd(":norm I* ")
        -- self._fillQflist()
    end

    function self._fillQflist(pattern)
        -- clear call setqflist([])
        -- fill quicklist with  current buffer cgetb
        -- fill quickfix with lines which starts with *  g/^* .*/cadde expand("%") .. ":" .. line(".") .. ":" .. getline(".") 

        -- g/.*:.*:\t.*/cadde getline(".")
        -- local fillQfcmd = 'g/^* .*/cadde strpart(getline("."), 2)'
        vim.fn.setqflist({})
        vim.cmd(pattern)
    end

    function self.split (inputstr, sep)
        if sep == nil then
            sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
        end
        return t
    end




    local function quickreplace(patternPara, replacePara)

        Pattern = patternPara
        Replace = replacePara

        self.splitBuffer(function (split)
            vim.cmd("set foldmethod=marker")
            vim.cmd("set nofoldenable")
            vim.cmd("set foldmarker=__________,__________")
            local result = cmdResult("rg ".. Pattern .. " --vimgrep"  )
            vim.api.nvim_buf_set_lines(split.bufnr, 0, 1, false, result)
        end)

    end

    function self.undo(bymark)
        if bymark then
            local fillQfcmd = 'g/^* .*/cadde strpart(getline("."), 2)'
            self._fillQflist(fillQfcmd)
        else
            local fillQfcmd = 'g/.*:.*:\t.*/cadde getline(".")'
            self._fillQflist(fillQfcmd)
        end
        vim.cmd("cdo s/"..Replace.."/"..Pattern.."/g")
    end

    function self.replace(bymark)
        if bymark then
            local fillQfcmd = 'g/^* .*/cadde strpart(getline("."), 2)'
            self._fillQflist(fillQfcmd)
        else
            local fillQfcmd = 'g/.*:.*:\t.*/cadde getline(".")'
            self._fillQflist(fillQfcmd)
        end
        vim.cmd("cdo s/"..Pattern.."/"..Replace.."/g")
    end


    return {
        quickreplace = quickreplace,
    }

end



