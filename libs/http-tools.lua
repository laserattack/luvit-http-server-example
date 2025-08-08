local http = require("http")

-- Функция http.get не блокирует выполнение кода. Она регистрирует запрос в event loop и сразу возвращает управление.
-- Когда ответ начинает приходить, event loop вызывает переданный колбэк (function(res)).
-- Этот коллбек регистрирует события в event loop (data, end, error)
-- Когда в сокет приходят данные, event loop вызывает соответствующий колбэк.

---@param callback function
local function httpGET(url, callback)
    url = http.parseUrl(url)
    local req = http.get(url, function(res)
        local body={}
        -- Летят кусочки, формируется тело ответа
        res:on('data', function(s) body[#body+1] = s end)
        -- Собираю все кусочки в строку
        res:on('end', function()
            res.body = table.concat(body)
            callback(res)
        end)
        -- Какая-то ошибка
        res:on('error', function(err) callback(res, err) end)
    end)
    -- Какая-то ошибка
    req:on('error', function(err) callback(nil, err) end)
end

return {
    httpGET = httpGET
}