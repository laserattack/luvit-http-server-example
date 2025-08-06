-- Тут задается директория, относительно который ищутся views
local fs = require('coro-fs').chroot("templates")

-- Функция рендера шаблона
local render = require("templater").render ---@type function

local function createPage()
    local template = assert(fs.readFile("home.html"))
    local page = render(template, {
        version = os.time()
    })
    return page
end

return {
    createPage = createPage
}