-- Тут задается директория, относительно который ищутся views
local fs = require('coro-fs').chroot("templates")

-- Функция рендера шаблона
local render = require("templater").render

local function createPage()
    local template = assert(fs.readFile("home.html"))
    local page = render(template, {
        title = "Главная страница",
        heading = "Добро пожаловать",
        time = os.date("%H:%M")
    })
    return page
end

return {
    createPage = createPage
}