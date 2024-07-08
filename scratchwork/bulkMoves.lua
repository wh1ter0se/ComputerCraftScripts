

function move_all(inv_from, inv_to)
    for slot, item in pairs(inv_from.list()) do
        inv_from.pushItems(peripheral.getName(inv_to), slot, 64)
    end
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

function run_manifest() 
    cobble_gen_output = peripheral.wrap("sophisticatedstorage:limited_barrel_2")
    crusher_input= peripheral.wrap("sophisticatedstorage:barrel_12")
    crusher_output= peripheral.wrap("sophisticatedstorage:barrel_14")
    washer_input = peripheral.wrap("sophisticatedstorage:barrel_10")
    washer_output = peripheral.wrap("sophisticatedstorage:barrel_5")
    blaster_input = peripheral.wrap("sophisticatedstorage:barrel_11")
    blaster_output = peripheral.wrap("sophisticatedstorage:barrel_4")
    storage_A1 = peripheral.wrap("sophisticatedstorage:barrel_13")
    storage_A2 = peripheral.wrap("sophisticatedstorage:barrel_15")
    storage_A3 = peripheral.wrap("sophisticatedstorage:limited_barrel_8")
    train_left = peripheral.wrap("create:portable_storage_interface_4")
    train_center = peripheral.wrap("create:portable_storage_interface_2")
    train_right = peripheral.wrap("create:portable_storage_interface_3")

    keep_type_stocked(cobble_gen_output, crusher_input, "minecraft:cobblestone", 64)
    -- keep_type_stocked(crusher_output, crusher_input, "minecraft:gravel", 64)
    move_all_by_types(crusher_output, washer_input, {"minecraft:gravel"})
    move_all_by_types(crusher_output, storage_A1, {"minecraft:flint", "minecraft:clay_ball", "minecraft:sand", "create:copper_nugget", "create:zinc_nugget", "minecraft:gold_nugget", "createaddition:electrum_nugget", "minecraft:iron_nugget"})
    move_all_by_types(crusher_output, blaster_input, {"create:crushed_raw_iron", "create:crushed_raw_gold", "create:crushed_raw_copper", "create:crushed_raw_zinc"})
    move_all(washer_output, storage_A1)
    move_all(blaster_output, storage_A1)
    move_all(train_left, storage_A2)
    move_all(train_center, storage_A2)
    move_all(train_right, storage_A2)
    move_all_by_types(crusher_output, storage_A1, {"create:experience_nugget"})
    move_all_by_types(storage_A2, storage_A1, {"create:experience_nugget"})
    move_all_by_types(storage_A2, blaster_input, {"minecraft:bow"})
    move_all_by_types(storage_A1, storage_A3, {"minecraft:flint"})
    move_all_by_types(storage_A1, storage_A3, {"minecraft:flint"})
    move_all_by_types(storage_A2, storage_A3, {"minecraft:flint"})
end

while true do
    succes, err = pcall(run_manifest)
    if succes then
        print("all items pushed")
    elseif err == "Terminated" then
        break
    else
        print(err)
    end
end