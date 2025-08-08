local fst = require('fs-tools')

-- Функция рендера шаблона
---@type function
local render = require("templater").render

local mdToHtml = require("markdown")

local function loadMdParts(dir)
    local parts = {}
    for filename in io.popen('ls '..dir..'/*.md 2>/dev/null'):lines() do
        local num = filename:match("/(%d+)%.md$")
        if num then
            parts[num] = mdToHtml(assert(fst.readFile(filename)))
        end
    end
    return parts
end

local function createPage()
    local template = assert(fst.readFile("templates/home.html"))
    local cachedAtUnix = os.time()
    local cachedAtDate = os.date("%c", cachedAtUnix)

    local pageParams = {
        version = cachedAtUnix,
        cachedAt = cachedAtDate,
    }

    -- Загружает все файлы вида <число>.md из директории parts
    local mdParts = loadMdParts("parts")
    for k, v in pairs(mdParts) do
        pageParams[k] = v
    end

    local page = render(template, pageParams)

    return page
end

return {
    createPage = createPage
}