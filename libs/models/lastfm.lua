local httpt = require("http-tools")
local json = require("json")
local fs = require('coro-fs').chroot("libs/models")

-- Загрузка конфига
local jsonContent, err = fs.readFile("lastfm.json")
if err then
    jsonContent, err = fs.readFile("lastfm-example.json")
    if err then
        print("load config error")
        os.exit(1)
    end
end
local config = json.decode(jsonContent)

-- Получение/обновление последнего трека
local lastTrack = ""
---@param callback function
local function getLastTrackFromLastFM(callback)
    local url = string.format(config.base_url, config.username, config.token)
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
        local trackName = data.recenttracks.track[1].name
        local artistName = data.recenttracks.track[1].artist["#text"]
        local formatted = string.format("%s - %s", trackName, artistName):gsub("🅴", "[E]")
        callback(formatted, nil)
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