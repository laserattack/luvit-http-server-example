-- Читает все содержимое файла, 
-- возвращает вторым аргументом ошибку если есть
local function readFile(path)
    local file, err = io.open(path, "r")
    if not file then
        return nil, err
    end
    local content = file:read("*a")
    file:close()
    return content
end

return {
    readFile = readFile
}