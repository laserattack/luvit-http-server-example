local cache = {}

-- Декоратор для кэширования ответов
---@param handler function
---@return function
return function(handler)
    return function(req, res)
        -- Если маршур есть в кэше - отдаем оттуда
        local cached = cache[req.path]
        if cached then
            res.body = cached.body
            res.code = cached.code
            res.headers = cached.headers
            return
        end
        -- Маршрута нет в кэше - вызывается оригинальный обработчик
        handler(req, res)
        -- В случе успеха результат сохраняется в кэш
        if res.code == 200 then
            cache[req.path] = {
                body = res.body,
                code = res.code,
                headers = res.headers,
                timestamp = os.time()
            }
        end
    end
end