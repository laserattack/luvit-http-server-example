local weblit = require('weblit')
local pathJoin = require('pathjoin').pathJoin ---@type function
local static = require('weblit-static') ---@type function

weblit.app

    .bind({ host = "0.0.0.0", port = 8080 })

    .use(require('weblit-logger'))
    .use(require('weblit-auto-headers'))

    .route({ method = "GET", path = "/" }, require("controllers/home"))
    .route({ method = "GET", path = "/about" }, require("controllers/about"))

    .use(static(pathJoin(module.dir, "assets")))

    .start()