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

function util.findTableIndex(table,key,value)
    for i = 1,#table,1 do
        if table[i][key] == value then return i end
    end
end

function util.ternary(cond, T, F)
    if cond then return T else return F end
end
