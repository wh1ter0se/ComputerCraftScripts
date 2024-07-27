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
    for i = 1, amount, 1 do
        Success = Success and func()
    end
    return Success
end

function util.findTableIndex(table, key, value)
    for i = 1, #table, 1 do
        if table[i][key] == value then return i end
    end
end

function util.ternary(cond, T, F)
    if cond then return T else return F end
end

function util.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function util.getKeys(table)
    local keys = {}
    local n = 0

    for k, v in pairs(tab) do
        n = n + 1
        keys[n] = k
    end

    return keys
end

function util.getVals(table)
    local vals = {}
    local n = 0

    for k, v in pairs(tab) do
        n = n + 1
        vals[n] = v
    end

    return vals
end
