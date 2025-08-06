local weblit = require('weblit')

---@type fun()
local static = require('weblit-static')

---@type fun()
local pathJoin = require('luvi').path.join

weblit.app

    .bind({ host = "0.0.0.0", port = 8080 })

    .use(require('weblit-logger'))
    .use(require('weblit-auto-headers'))

    .route({ method = "GET", path = "/" }, require("controllers.home"))
    .route({ method = "GET", path = "/about" }, require("controllers.about"))

    ---@diagnostic disable-next-line undefined-field
    .use(static(pathJoin(module.dir, "assets")))

    .start()