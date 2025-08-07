local weblit = require('weblit')

---@type function
local pathJoin = require('pathjoin').pathJoin

---@type function
local static = require('weblit-static')

-- Декоратор для кэширования запросов в RAM
local c = require('cache')

-- Периодическое обновление трека LastFM
do
    local lastfm = require('models/lastfm')
    local timer = require('timer')
    lastfm.updateLastTrack()
    timer.setInterval(15000, function()
        lastfm.updateLastTrack()
    end)
end

weblit.app
    .bind({ host = "0.0.0.0", port = 8080 })

    .use(require('weblit-logger'))
    .use(require('weblit-auto-headers'))

    .route({ method = "GET", path = "/" }, c(require("controllers/home")))
    .route({ method = "GET", path = "/api/lastfm" }, require("controllers/lastfm"))

    .use(static(pathJoin(module.dir, "assets")))

    .start()