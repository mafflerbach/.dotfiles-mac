function convertToTable(str)

    local t={}
    for str in string.gmatch(str, "([^\n]+)") do
        table.insert(t, str)
    end
    return t
end


function cmdResult(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()

print(vim.inspect(result))

    return convertToTable(result)

end
