cobble_gen_output = peripheral.wrap("sophisticatedstorage:limited_barrel_2")
crusher_input= peripheral.wrap("sophisticatedstorage:barrel_12")
crusher_output= peripheral.wrap("sophisticatedstorage:barrel_14")
washer_input = peripheral.wrap("sophisticatedstorage:barrel_10")
washer_output = peripheral.wrap("sophisticatedstorage:barrel_5")
barrel_1 = peripheral.wrap("sophisticatedstorage:barrel_13")

function dump_cobble()
    total_cobble = 0
    
    for slot, item in pairs(crusher_output.list()) do
        if item.getName() == "minecraft:cobblestone" and item.count then
            total_cobble = total_cobble + item.count
        end
    end
    if total_cobble < 64 then
        cobble_gen_output.pushItems(peripheral.getName(crusher_input), 1, 64)
    end
end

function dump_gravel()
    for slot, item in pairs(crusher_output.list()) do
        if item.getName() == "minecraft:gravel" then
            crusher_output.pushItems(peripheral.getName(washer_input), slot, 64)
        end
    end
end

function dump_washer_byproducts()
    for slot, item in pairs(washer_output.list()) do
        washer_output.pushItems(peripheral.getName(barrel_1), slot, 64)
    end
end

while true do
    dump_cobble()
    dump_gravel()
    dump_washer_byproducts()
    sleep(1)
end