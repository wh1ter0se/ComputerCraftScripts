cobble_gen = peripheral.wrap("sophisticatedstorage:limited_barrel_0")
concrete_gen_input = peripheral.wrap("sophisticatedstorage:limited_barrel_1")
washer_output = peripheral.wrap("sophisticatedstorage:barrel_1")
train = peripheral.wrap("sophisticatedstorage:barrel_2")

function fill_concrete()
    curr_num =  concrete_gen_input.getItemDetail(1)
    if (not curr_num) or (curr_num.count < 64) then
        cobble_gen.pushItems(peripheral.getName(concrete_gen_input), 1, 64)
    end
end

function dump_washed_material()
    if not redstone.getInput("top") then
        for slot, item in pairs(washer_output.list()) do
            washer_output.pushItems(peripheral.getName(train), slot, 4096)
        end
    end
end


while true do
    fill_concrete()
    dump_washed_material()
    sleep(10)
end
