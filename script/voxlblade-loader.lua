local BASE = "https://raw.githubusercontent.com/XDar4kX/Testing00/main/script/files/"

getgenv().SX_VM_CNONE = getgenv().SX_VM_CNONE or function() end
getgenv().getServerConstant = getgenv().getServerConstant or function(v)
    return v
end
getgenv().clonefunction = getgenv().clonefunction or function(f)
    return f
end

local cache = {}

getgenv().sharedRequire = function(path)
    path = path:gsub("^@", "")
    path = path:gsub("^/", "")
    path = path:gsub("^%./", "utils/")
    path = path:gsub("^%.%./", "")
    path = path:gsub("^Utils/", "utils/")
    path = path:gsub("^Classes/", "classes/")

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
