local function index(req, res)
    local body = "About page\n"
    res:setHeader("Content-Type", "text/plain")
    res:setHeader("Content-Length", #body)
    res:finish(body)
end

return index