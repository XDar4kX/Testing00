local BASE = "https://raw.githubusercontent.com/XDar4kX/Testing00/main/script/files/"

local cache = {}

getgenv().sharedRequire = function(path)
    path = path:gsub("^@", "")
    path = path:gsub("^/", "")

    if cache[path] then
        return cache[path]
    end

    local source = game:HttpGet(BASE .. path)
    local fn, err = loadstring(source, path)

    if not fn then
        error(("Failed to load %s:\n%s"):format(path, err))
    end

    local result = fn()
    cache[path] = result
    return result
end

loadstring(game:HttpGet(BASE .. "games/VoxlBlade.lua"))()
