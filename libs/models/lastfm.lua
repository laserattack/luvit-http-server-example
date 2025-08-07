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

local last_track = ""

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
        local track_name = data.recenttracks.track[1].name
        local artist_name = data.recenttracks.track[1].artist["#text"]
        local formatted = string.format("%s - %s", track_name, artist_name):gsub("🅴", "[E]")
        callback(formatted, nil)
    end)
end

local function updateLastTrack()
    getLastTrackFromLastFM(function(res, err)
        last_track = (not err and res ~= "") and res or last_track
    end)
end

return {
    updateLastTrack = updateLastTrack,
    lastTrack = function() return last_track end
}