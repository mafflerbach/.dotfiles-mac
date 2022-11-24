local M = {}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"

local action_state = require "telescope.actions.state"
local previewers = require("telescope.previewers")
local scan = require'plenary.scandir'

vim.notify = require("notify")
function M.setup()

end

function M.find()
    local scandir = scan.scan_dir('/home/maren/.zettelkasten', { hidden = false, depth = 2})
    local Job = require'plenary.job'

    local Job = require'plenary.job'
    local foo = Job:new({
        command = 'rg',
        args = { '--files' },
        cwd = '/home/maren/.zettelkasten',
        -- env = { ['a'] = 'b' },
        on_exit = function(j, return_val)
            return  return_val
        end,
    }):sync()
    -- print(vim.inspect(scandir))

    local fileFinder = function(opts)
        opts = opts or {}
        pickers.new(opts, {
            finder = finders.new_table {
                results = foo
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)

                    local selection = action_state.get_selected_entry()
                    local filename = selection[1]

                end)
                return true
            end,
        }):find()
    end

    -- to execute the function
    fileFinder ()
    print("find")
end

function M.follow_link()

end

function M.insert_link()

end

function M.new_note()

    print("new note")
end

function M.rename_note()

end

function M.yank_notelink()

end

function M.goto_today()

end

function M.toggle_todo()

end

function M.find_media()

end

function M.preview_img()

end

function M.show_tags()
    print("show tag")
end

function M.show_calendar()

end



return M
