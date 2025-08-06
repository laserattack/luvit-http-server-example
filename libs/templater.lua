---@param template string
---@param data table
---@return string
local function render(template, data)
    -- key - то что в захвате, т.е. .-
    -- а gsub заменяет всё совпадение на результат функции,
    -- всё совпадение тут - {{...}} т.е. включая скобки
    return (template:gsub("{{%s*(.-)%s*}}", function(key)
        return tostring(data[key] or "")
    end))
end

return {
    render = render
}