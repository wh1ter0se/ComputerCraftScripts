elevatorProtocol = arg[1]  -- "elevator_oasis_NW"
elevatorFloor    = arg[2] -- "L1"
modemSide        = arg[3] or "bottom"
buttonSide       = arg[4] or "back"

elevatorInfoProtocol = elevatorProtocol.."_info"

rednet.open(modemSide)
rednet.host(elevatorProtocol, "floor_"..tostring(elevatorFloor))


function requestElevator()
    print("[CLIENT] Requesting elevator to "..elevatorFloor.."...")
    elevatorServerId = rednet.lookup(elevatorProtocol, "server")
    rednet.send(elevatorServerId, "request;"..elevatorFloor, elevatorProtocol)
end

while true do 
    eventData = {os.pullEvent()}
    if eventData[1] == "redstone" and redstone.getInput(buttonSide) then
        success = pcall(requestElevator)
        if not success then
            print("Failed to call elevator")
        end

    elseif eventData[1] == "rednet_message"  and 
           eventData[4] == elevatorInfoProtocol then
        print("[SERVER] "..eventData[3])
    end
end