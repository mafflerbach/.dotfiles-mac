
Jira.utilities = {}

Jira.utilities.char_to_hex = function(c)
  return string.format("%%%02X", string.byte(c))
end

function Jira.utilities.urlencode(url)
  if url == nil then
    return
  end
  url = url:gsub("\n", "\r\n")
  url = url:gsub("([^%w ])", Jira.utilities.char_to_hex)
  url = url:gsub(" ", "+")
  return url
end

Jira.utilities.hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

Jira.utilities.urldecode = function(url)
  if url == nil then
    return
  end
  url = url:gsub("+", " ")
  url = url:gsub("%%(%x%x)", Jira.utilities.hex_to_char)
  return url
end
