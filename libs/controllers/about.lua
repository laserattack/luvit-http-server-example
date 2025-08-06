local model = require("models/about")

return function (req, res)
    res.body = model.createPage()
    res.code = 200
    res.headers["Content-Type"] = "text/html; charset=utf-8"
end