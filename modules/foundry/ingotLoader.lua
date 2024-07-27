
ingotType       = arg[1]
basinSide       = arg[2] or "left"
basinBufferSide = arg[3] or "bottom"

function get_inv(invName)
    inv = peripheral.wrap(invName)
    if inv == nil then
        print("missing inventory: "..invName)
    end
    return inv
end

function move_all_by_types(inv_from, inv_to, typeNames)
    for slot, item in pairs(inv_from.list()) do
        for _, typeName in pairs(typeNames) do
            if item.name == typeName then
                inv_from.pushItems(peripheral.getName(inv_to), slot, 64)
            end
        end
    end
end

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

function updateSteel()
    ironSource = get_inv("sophisticatedstorage:limited_barrel_14")
    charcoalSource = get_inv("sophisticatedstorage:barrel_13")
    basinBufferGlobal = get_inv("sophisticatedstorage:barrel_25")

    basinBufferLocal = get_inv(basinBufferSide)
    basin = get_inv(basinSide)
    smelter = get_inv("sophisticatedstorage:barrel_24")

    keep_type_stocked(ironSource, basinBufferGlobal, "minecraft:iron_ingot", 16)
    keep_type_stocked(basinBufferLocal, basin, "minecraft:iron_ingot", 16)

    keep_type_stocked(charcoalSource, basinBufferGlobal, "minecraft:charcoal", 16)
    keep_type_stocked(basinBufferLocal, basin, "minecraft:charcoal", 16)

    move_all_by_types(basin, basinBufferLocal, {"alloyed:steel_ingot"})
    move_all_by_types(basinBufferGlobal, smelter, {"alloyed:steel_ingot"})
end

while true do 
    if ingotType == "steel" then
        updateSteel()
    end
    sleep(1)
end