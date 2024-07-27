function fill(inv_from, inv_to)
    inv_from.pushFluid(peripheral.getName(inv_to))
end


function runManifest() 
    sleep(2)

    rednet.open("back")

    -- lava
    utility_reserve_lava_tank = peripheral.wrap("create:fluid_tank_4")
    foundry_lava_tank = peripheral.wrap("create:fluid_tank_8")
    airport_station_lava_tank = peripheral.wrap("create:fluid_tank_3")

    -- steel
    foundry_steel_tank = peripheral.wrap("create:fluid_tank_13")
    assembly_room_steel_tank = peripheral.wrap("create:fluid_tank_9")
    
    fill(utility_reserve_lava_tank, foundry_lava_tank)
    fill(utility_reserve_lava_tank, airport_station_lava_tank)
    fill(foundry_steel_tank, assembly_room_steel_tank)

end


while true do
    success, err = pcall(runManifest)
    if success then
        print("all fluids pushed")
    elseif err == "Terminated" then
        break
    else
        print(err)
    end
end