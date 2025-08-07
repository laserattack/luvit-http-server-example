local model = require("models/lastfm")

return function (req, res)
    res.body = model.lastTrack()
    res.code = 200
    res.headers["Content-Type"] = "text/html; charset=utf-8"
end