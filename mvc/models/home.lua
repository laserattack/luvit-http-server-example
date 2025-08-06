-- Тут задается директория, относительно который ищутся views
local pwd = require("tools/env").pwd
local pathJoin = require('pathjoin').pathJoin ---@type function
local fs = require('coro-fs').chroot(pathJoin(pwd(), "mvc/views"))

-- Функция рендера шаблона
local render = require("tools/templater").render

local function createPage()
    local template = fs.readFile("home.html")
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