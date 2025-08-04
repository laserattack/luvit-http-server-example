local server_ip = "127.0.0.1"
local server_port = "8080"
local log_file = io.stdout

local http = require('http')

-- Маршруты и соответствующие им контроллеры
local routes = {
    ["/"] = require("controllers.home").index,
    ["/about"] = require("controllers.about").index
}

-- Возвращает лучший маршрут (самый похожий на запрашиваемый URL)
-- и соответствующий ему контроллер
function routes:findBestRoute(url)
    if self[url] then return url, self[url] end

    local bestRoute = "/"
    local bestLength = 1

    for route in pairs(self) do
        if url:sub(1, #route) == route and #route > bestLength then
            bestRoute, bestLength = route, #route
        end
    end

    return bestRoute, self[bestRoute]
end

local function onRequest(req, res)
    do
        -- Логирование запроса
        local user_ip = req.socket:address().ip
        local method = req.method
        local url = req.url
        local time = os.date()
        log_file:write(
            string.format(
                "[%s] %s %s %s\n",
                time, user_ip, method, url
            )
        )
    end

    do
        -- Обработка запроса
        local route, controller = routes:findBestRoute(req.url)
        req.url = route; controller(req, res)
    end
end

local function main()
    do
        -- Запуск сервера
        local server = http.createServer(onRequest)
        server:listen(server_port, server_ip)
        log_file:write(
            string.format(
                "Server running at %s:%s\n",
                server_ip, server_port)
        )
    end
end

main()