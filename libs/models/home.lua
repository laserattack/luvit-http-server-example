-- Тут задается директория, относительно который ищутся views
local fs = require('coro-fs')

-- Функция рендера шаблона
---@type function
local render = require("templater").render

local mdToHtml = require("markdown")

local function loadMdParts(dir)
    local parts = {}
    for filename in io.popen('ls '..dir..'/*.md 2>/dev/null'):lines() do
        local num = filename:match("/(%d+)%.md$")
        if num then
            parts[num] = mdToHtml(assert(fs.readFile(filename)))
        end
    end
    return parts
end

local function createPage()
    local template = assert(fs.readFile("templates/home.html"))
    local cached_at_unix = os.time()
    local cached_at_date = os.date("%c", cached_at_unix)

    local pageParams = {
        version = cached_at_unix,
        cached_at = cached_at_date,
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