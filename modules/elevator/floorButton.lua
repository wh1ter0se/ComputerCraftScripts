elevatorProtocol = arg[1]  -- "elevator_oasis_NW"
elevatorFloor    = arg[2] -- "Level 1"
modemSide        = arg[3] or "left"
buttonSide       = arg[4] or "back"

rednet.host(elevatorProtocol, "floor_"..tostring(elevatorFloor))


function requestElevator()
    print("Requesting elevator to "..elevatorFloor)
    elevatorServerId = rednet.lookup(elevatorProtocol, "server")
    print(elevatorServerId)
    rednet.send(elevatorServerId, "request;"..elevatorFloor, elevatorProtocol)
end

function printElevatorStatus(message)
    print(message)
end

while true do 
    eventData = os.pullEvent()
    if eventData == "redstone" and redstone.getInput(buttonSide) then
        success = pcall(requestElevator)
        if not success then
            print("Failed to call elevator")
        end

    elseif eventData[1] == "rednetMessage"  and 
           eventData[4] == elevatorProtocol then
        printElevatorStatus(eventData[3])
    end
end