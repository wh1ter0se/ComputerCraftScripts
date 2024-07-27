function get_inv(invName)
    inv = peripheral.wrap(invName)
    if inv.list() == nil then
        print("missing inventory: " .. invName)
    end
    return inv
end

function move_all(inv_from, inv_to)
    for slot, item in pairs(inv_from.list()) do
        inv_from.pushItems(peripheral.getName(inv_to), slot, 64)
    end
end

function move_all_by_types(inv_from, inv_to, typeNames)
    local amountTransferred = 0
    for slot, item in pairs(inv_from.list()) do
        for _, typeName in pairs(typeNames) do
            if item.name == typeName then
                amountTransferred = amountTransferred + inv_from.pushItems(peripheral.getName(inv_to), slot, 64)
            end
        end
    end
end

function keep_type_stocked(inv_from, inv_to, typeName, minAmount)
    current_amount = 0

    for slot, item in pairs(inv_to.list()) do
        if item.name == typeName and item.count then
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

function runManifest()
    cobble_gen_output = get_inv("sophisticatedstorage:limited_barrel_2")

    crusher_input = get_inv("sophisticatedstorage:barrel_12")
    crusher_output = get_inv("sophisticatedstorage:barrel_14")

    washer_input = get_inv("sophisticatedstorage:barrel_10")
    washer_output = get_inv("sophisticatedstorage:barrel_5")
    blaster_input = get_inv("sophisticatedstorage:barrel_11")
    blaster_output = get_inv("sophisticatedstorage:barrel_4")

    storage_A101 = get_inv("sophisticatedstorage:limited_barrel_8")  -- flint
    storage_A102 = get_inv("sophisticatedstorage:limited_barrel_9")  -- clay balls
    storage_A103 = get_inv("sophisticatedstorage:limited_barrel_10") -- gunpowder
    storage_A104 = get_inv("sophisticatedstorage:limited_barrel_12") -- bones
    storage_A105 = get_inv("sophisticatedstorage:limited_barrel_13") -- rotten flesh
    storage_A106 = get_inv("sophisticatedstorage:barrel_15")         -- general input
    storage_A107 = get_inv("sophisticatedstorage:barrel_13")         -- factory outputs

    storage_A108 = get_inv("sophisticatedstorage:barrel_13")         -- iron
    storage_A109 = get_inv("sophisticatedstorage:barrel_13")         -- gold

    storage_A114 = get_inv("sophisticatedstorage:barrel_26")         -- unassigned
    storage_A115 = get_inv("sophisticatedstorage:barrel_27")         -- backpacks
    storage_A116 = get_inv("sophisticatedstorage:barrel_28")         -- discs
    storage_A117 = get_inv("sophisticatedstorage:barrel_23")         -- concrete amd dyes

    storage_A201 = get_inv("sophisticatedstorage:limited_barrel_11") -- gravel
    storage_A202 = get_inv("sophisticatedstorage:limited_barrel_15") -- sand
    storage_A203 = get_inv("sophisticatedstorage:limited_barrel_16") -- unassigned

    train_left = get_inv("create:portable_storage_interface_4")
    train_center = get_inv("create:portable_storage_interface_2")
    train_right = get_inv("create:portable_storage_interface_3")

    concrete_mixer_input = get_inv("sophisticatedstorage:barrel_31")
    concrete_mixer_output = get_inv("sophisticatedstorage:barrel_29")

    -- gravel generator
    keep_type_stocked(cobble_gen_output, crusher_input, "minecraft:cobblestone", 64)
    keep_type_stocked(crusher_output, concrete_mixer_input, "minecraft:gravel", 64)
    keep_type_stocked(crusher_output, washer_input, "minecraft:gravel", 64)
    move_all_by_types(crusher_output, storage_A101, { "minecraft:flint" })
    move_all_by_types(crusher_output, storage_A102, { "minecraft:clay_ball" })
    move_all_by_types(crusher_output, storage_A107, {
        "minecraft:sand",
        "minecraft:iron_nugget",
        "minecraft:gold_nugget",
        "create:copper_nugget",
        "create:zinc_nugget",
        "create:experience_nugget",
        "createaddition:electrum_nugget" })
    move_all_by_types(crusher_output, blaster_input, {
        "create:crushed_raw_iron",
        "create:crushed_raw_gold",
        "create:crushed_raw_copper",
        "create:crushed_raw_zinc" })
    move_all_by_types(crusher_output, crusher_input, { "minecraft:gravel" })


    -- pneumatic room
    move_all(concrete_mixer_output, washer_input)
    move_all(washer_output, storage_A107)
    move_all(blaster_output, storage_A107)


    -- collect train loot
    move_all(train_left, storage_A106)
    move_all(train_center, storage_A106)
    move_all(train_right, storage_A106)

    -- factory
    

    -- redistribute
    keep_type_stocked(storage_A107, concrete_mixer_input, "minecraft:sand", 64)
    move_all_by_types(storage_A106, storage_A101, { "minecraft:flint" })
    move_all_by_types(storage_A106, storage_A103, { "minecraft:gunpowder" })
    move_all_by_types(storage_A106, storage_A104, { "minecraft:bone" })
    move_all_by_types(storage_A106, storage_A104, { "minecraft:rotten_flesh" })
    move_all_by_types(storage_A106, storage_A107, {
        "minecraft:iron_ingot",
        "minecraft:iron_nugget",
        "create:experience_nugget" })
    move_all_by_types(storage_A106, storage_A115, {
        "sophisticatedbackpacks:backpack",
        "sophisticatedbackpacks:iron_backpack",
        "sophisticatedbackpacks:gold_backpack",
        "sophisticatedbackpacks:diamond_backpack",
        "sophisticatedbackpacks:netherite_backpack" })
    move_all_by_types(storage_A106, storage_A116, {
        "minecraft:music_disc_11",
        "minecraft:music_disc_13",
        "minecraft:music_disc_blocks",
        "minecraft:music_disc_cat",
        "minecraft:music_disc_chirp",
        "minecraft:music_disc_far",
        "minecraft:music_disc_mall",
        "minecraft:music_disc_mellchi",
        "minecraft:music_disc_stal",
        "minecraft:music_disc_strad",
        "minecraft:music_disc_wait",
        "minecraft:music_disc_ward",
        "minecraft:music_disc_pigstep", })
    move_all_by_types(storage_A106, blaster_input, {
        "minecraft:bow",
        "minecraft:leather_boots",
        "minecraft:leather_leggings",
        "minecraft:leather_chestplate",
        "minecraft:leather_helmet" })
    move_all_by_types(storage_A107, storage_A101, { "minecraft:flint" })
    move_all_by_types(storage_A107, storage_A102, { "minecraft:clay_ball" })
    move_all_by_types(storage_A107, storage_A108, {
        "minecraft:iron_nugget",
        "minecraft:iron_ingot",
        "minecraft:iron_block" })
    move_all_by_types(storage_A107, storage_A109, {
        "minecraft:gold_nugget",
        "minecraft:gold_ingot",
        "minecraft:gold_block" })
    move_all_by_types(storage_A107, storage_A201, { "minecraft:gravel" })
    move_all_by_types(storage_A107, storage_A202, { "minecraft:sand" })
    move_all_by_types(storage_A107, storage_A117, { "minecraft:white_concrete" })
end

while true do
    success, err = pcall(runManifest)
    if success then
        print("all items pushed")
    elseif err == "Terminated" then
        break
    else
        print(err)
    end
end
