
function Youtube()

    function cmdResult(cmd)
        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()

        return result
    end

    local getEmbedCode = function ()
        local videoUrl=  vim.fn.expand("<cWORD>")
        local cmd = "generateEmbedTag.sh " .. videoUrl
        local embedCode=cmdResult(cmd)
        vim.fn.setreg("+", embedCode)
        vim.notify(embedCode, "info")
    end

    return {
        getEmbedCode= getEmbedCode
    }
end


