util = {}

function util.listContains(list, val)
    for index, value in ipairs(list) do
        if value == val then
            return true
        end
    end
    return false
end

function util.repeatFunc(amount, func)
    if not amount then amount = 1 end
    Success = true
    for i = 1,amount,1 do
        Success = Success and func()
    end
    return Success
end