-- Тут задается директория, относительно который ищутся views
local fs = require('coro-fs')

-- Функция рендера шаблона
---@type function
local render = require("templater").render

local mdToHtml = require("markdown")

local function createPage()
    local template = assert(fs.readFile("templates/home.html"))
    local cached_at_unix = os.time()
    local cached_at_date = os.date("%c", cached_at_unix)

    -- md parts
    local firstPart = mdToHtml(assert(fs.readFile("parts/first.md")))
    local secondPart = mdToHtml(assert(fs.readFile("parts/second.md")))
    local thirdPart = mdToHtml(assert(fs.readFile("parts/third.md")))

    local page = render(template, {
        version = cached_at_unix,
        cached_at = cached_at_date,
        -- md parts
        firstPart = firstPart,
        secondPart = secondPart,
        thirdPart = thirdPart
    })
    return page
end

return {
    createPage = createPage
}