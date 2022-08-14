--
--
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"


local conf = require("telescope.config").values
-- our picker function: colors

local function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end
local function lines_from(file)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do 
        lines[#lines + 1] = line
    end
    return lines
end

local function getContent() 


local jbehaveCommandList = vim.env.XDG_CONFIG_HOME .. '/nvim/lua/telescope_jbehave/jbehaveCommandList.txt'

    local file = jbehaveCommandList
    local lines = lines_from(file)

    return lines
end


jbehaveCompletion = function(opts)
    opts = opts or {}

    pickers.new(opts, {
        prompt_title = "colors",
        finder = finders.new_table {
            results = getContent()
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                --print(vim.inspect(selection))
                vim.api.nvim_put({ selection[1] }, "", false, true)
            end)
            return true
        end,
    }):find()
end

-- to execute the functions
--jbhaveCompletion()



