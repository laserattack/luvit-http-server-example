local weblit = require('weblit')

---@type function
local pathJoin = require('pathjoin').pathJoin

---@type function
local static = require('weblit-static')

-- Декоратор для кэширования запросов
local c = require('cache')

weblit.app
    .bind({ host = "0.0.0.0", port = 8080 })
    .use(require('weblit-logger'))
    .use(require('weblit-auto-headers'))

    .route({ method = "GET", path = "/" }, c(require("controllers/home")))

    .use(static(pathJoin(module.dir, "assets")))
    .start()