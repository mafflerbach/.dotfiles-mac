function JsonFormatter()

    local self = {}



    function self.get_visual_selection()
        local s_start = vim.fn.getpos("'<")
        local s_end = vim.fn.getpos("'>")
        local n_lines = math.abs(s_end[2] - s_start[2]) + 1
        local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
        lines[1] = string.sub(lines[1], s_start[3], -1)
        if n_lines == 1 then
            lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
        else
            lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
        end
        return table.concat(lines, '\n')
    end



    function self.cmdResult(body)

        local cmd = "echo '"..body.."' | jq "
        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()

        return convertToTable(result)

    end

    function self.convertToTable(str)

        local t={}
        for str in string.gmatch(str, "([^\n]+)") do
            table.insert(t, str)
        end

        return t
    end
    local function formatLine()

        local region = vim.api.nvim_get_current_line()
        local result = self.cmdResult(region)
        local buf = vim.api.nvim_get_current_buf()
        local currentLineNumber = vim.api.nvim_win_get_cursor(0)
        vim.api.nvim_buf_set_lines(buf, currentLineNumber[1], currentLineNumber[1], false, result)
    end

    local function formatFile()

        vim.cmd("%!jq '.'")
    end
    local function formatInNewVSplit()
        self.NewBuffer('vsplit')
    end
    local function formatInNewSplit()

        self.NewBuffer('split')
    end

    local function formatSelection()
        local region = self.get_visual_selection()
        local result = self.cmdResult(region)
        local buf = vim.api.nvim_get_current_buf()
        local currentLineNumber = vim.api.nvim_win_get_cursor(0)

        vim.api.nvim_buf_set_lines(buf, currentLineNumber[1], currentLineNumber[1], false, result)
    end

    function self.NewBuffer(orientation)

        local region = self.get_visual_selection()
        local result = self.cmdResult(region)
        local buf = vim.api.nvim_get_current_buf()
        local currentLineNumber = vim.api.nvim_win_get_cursor(0)

        vim.cmd(orientation)
        local win = vim.api.nvim_get_current_win()
        buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_win_set_buf(win, buf)
        vim.bo.filetype="json"

        vim.api.nvim_buf_set_lines(buf, currentLineNumber[1], currentLineNumber[1], false, result)
    end


    function self.getBufferContent()

        local region = vim.api.nvim_get_current_line()
        local content = self.cmdResult(region)
        local buf = vim.api.nvim_get_current_buf()
        local currentLineNumber = vim.api.nvim_win_get_cursor(0)


        return {currentLineNumber = currentLineNumber, buf=buf, content=content}
    end
    local function formatLineInNewVSplit()

        local region = vim.api.nvim_get_current_line()
        local result = self.cmdResult(region)
        local buf = vim.api.nvim_get_current_buf()
        local currentLineNumber = vim.api.nvim_win_get_cursor(0)


        vim.cmd('vsplit')
        local win = vim.api.nvim_get_current_win()
        buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_win_set_buf(win, buf)
        vim.bo.filetype="json"


        vim.api.nvim_buf_set_lines(buf, currentLineNumber[1], currentLineNumber[1], false, result)
    end

    local function formatLineInNewSplit()

        local region = vim.api.nvim_get_current_line()
        local result = self.cmdResult(region)
        local buf = vim.api.nvim_get_current_buf()
        local currentLineNumber = vim.api.nvim_win_get_cursor(0)


        vim.cmd('split')
        local win = vim.api.nvim_get_current_win()
        buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_win_set_buf(win, buf)
        vim.bo.filetype="json"


        vim.api.nvim_buf_set_lines(buf, currentLineNumber[1], currentLineNumber[1], false, result)
    end

    -- lua JsonFormatter().formatFile()
    -- lua JsonFormatter().formatLine()
    -- lua JsonFormatter().formatLineInNewSplit()
    -- lua JsonFormatter().formatLineInNewVSplit()
    -- lua JsonFormatter().formatSelection()
    -- lua JsonFormatter().formatInNewVSplit()
    -- lua JsonFormatter().formatInNewSplit()



    return {
        formatFile = formatFile,
        formatLine = formatLine,
        formatLineInNewSplit = formatLineInNewSplit,
        formatLineInNewVSplit = formatLineInNewVSplit,
        formatSelection = formatSelection,
        formatInNewSplit = formatInNewSplit,
        formatInNewVSplit = formatInNewVSplit,

    }
end
