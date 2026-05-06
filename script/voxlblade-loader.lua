local BASE = "https://raw.githubusercontent.com/XDar4kX/Testing00/main/script/files/"

local cache = {}

getgenv().sharedRequire = function(path)
    path = path:gsub("^@", "")
    path = path:gsub("^/", "")

    path = path:gsub("^Utils/", "utils/")
    path = path:gsub("^utils/", "utils/")
    path = path:gsub("^Classes/", "classes/")
    path = path:gsub("^classes/", "classes/")

    if cache[path] then
        return cache[path]
    end

    local url = BASE .. path
    local source = game:HttpGet(url)

    if source:sub(1, 3) == "404" then
        error("GitHub file not found: " .. url)
    end

    local fn, err = loadstring(source, path)
    if not fn then
        error(("Failed to load %s:\n%s"):format(path, err))
    end

    local result = fn()
    cache[path] = result
    return result
end

loadstring(game:HttpGet(BASE .. "games/VoxlBlade.lua"))()
