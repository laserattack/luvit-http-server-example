local httpt = require("http-tools")
local fst = require('fs-tools')
local json = require("json")

---@type function
local pathJoin = require('pathjoin').pathJoin

-- Загрузка конфига
local jsonContent, err = fst.readFile(pathJoin(module.dir, "lastfm.json"))
if err then
    jsonContent, err = fst.readFile(pathJoin(module.dir, "lastfm-example.json"))
    if err then
        io.write("load config error: ", err, "\n")
        os.exit(1)
    end
end
local config = json.decode(jsonContent)

-- Получение/обновление последнего трека

-- getLastTrackFromLastFM не блокирует выполнение кода
-- она передает функцию (function(res, err)) как коллбек в httpGET и сразу завершается
-- а в httpGET уже по достижении события в event loop этот коллбек вызовется

local lastTrack = ""
---@param callback function
local function getLastTrackFromLastFM(callback)
    local url = string.format(config.baseUrl, config.username, config.token)
    httpt.httpGET(url, function(res, err)
        -- Возможные ошибки при получении HTTP-запроса
        if err then
            callback(nil, err)
            return
        end
        -- Ошибки в структуре JSON
        local success, data = pcall(json.decode, res.body)
        if not success then
            callback(nil, "json parse error")
            return
        end
        -- Что-то не тако с ответом (нет нужных полей)
        if not data.recenttracks or not data.recenttracks.track or #data.recenttracks.track == 0 then
            callback(nil, "no tracks found")
            return
        end
        -- Коллбек
        local track = data.recenttracks.track[1]
        callback(json.encode(track), nil)
    end)
end
local function updateLastTrack()
    getLastTrackFromLastFM(function(res, err)
        lastTrack = (not err and res ~= "") and res or lastTrack
    end)
end

return {
    updateLastTrack = updateLastTrack,
    lastTrack = function() return lastTrack end
}