basinSide       = arg[1] or "back"
basinBufferSide = arg[2] or "top"

function keep_type_stocked(inv_from, inv_to, typeName, minAmount)
    current_amount = 0
    
    for slot, item in pairs(inv_to.list()) do
        if item.name== typeName and item.count then
            current_amount = current_amount + item.count
        end
    end

    if current_amount < minAmount then
        amount_needed = minAmount - current_amount
        for slot, item in pairs(inv_from.list()) do
            if item.name == typeName then
                amount_needed = amount_needed - inv_from.pushItems(peripheral.getName(inv_to), slot, 64)
            end
            if amount_needed <= 0 then
                break
            end
        end
    end
end

function load()
    basinBufferLocal = peripheral.wrap(basinBufferSide)
    basin = peripheral.wrap(basinSide)

    keep_type_stocked(basinBufferLocal, basin, "minecraft:sand", 16)
    keep_type_stocked(basinBufferLocal, basin, "minecraft:gravel", 16)
end

while true do
    load()
    sleep(1)
end