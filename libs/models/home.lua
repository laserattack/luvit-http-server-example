-- Тут задается директория, относительно который ищутся views
local fs = require('coro-fs').chroot("templates")

-- Функция рендера шаблона
local render = require("templater").render ---@type function

local function createPage()
    local template = assert(fs.readFile("home.html"))
    local cached_at_unix = os.time()
    local cached_at_date = os.date("%c", cached_at_unix)
    local page = render(template, {
        version = cached_at_unix,
        cached_at = cached_at_date
    })
    return page
end

return {
    createPage = createPage
}