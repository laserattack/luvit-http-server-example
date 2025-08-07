local model = require("models/lastfm")

return function (req, response)
    response.body = model.lastTrack()
    response.code = 200
    response.headers["Content-Type"] = "text/html; charset=utf-8"
end