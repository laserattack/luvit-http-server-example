local ip = "127.0.0.1"
local port = "8080"

local http = require('http')

local function reqLog(req, output)
    local addr = req.socket:address()
    local method = req.method
    local url = req.url
    local time = os.date("%Y-%m-%d %H:%M:%S")
    output:write(
        string.format(
            "[%s] %s %s %s\n",
            time,
            addr.ip,
            method,
            url
        )
    )
end

local routes = {
    ["/"] = require("controllers.home").index,
    ["/about"] = require("controllers.about").index
}

local function onRequest(req, res)
    reqLog(req, io.stdout)

    local handler = routes[req.url]
    if handler then
        handler(req, res)
    else
        local body = "404 Not Found\n"
        res:setHeader("Content-Type", "text/plain")
        res:setHeader("Content-Length", #body)
        res.statusCode = 404
        res:finish(body)
    end
end

local server = http.createServer(onRequest)
server:listen(port, ip)
io.write("Server running at ", ip, ":", port, "\n")