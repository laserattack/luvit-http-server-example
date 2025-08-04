local function starts_with(sting, substring)
    for i = 1, #substring do
        if sting:byte(i) ~= substring:byte(i) then
            return false
        end
    end
    return true
end

return {
    starts_with = starts_with
}