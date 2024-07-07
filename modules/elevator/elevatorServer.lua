require("shared/dns")
json = require("shared/json")

elevatorProtocol = arg[1]  -- "elevator_oasis_NW"
motorPeripheral  = arg[2]  -- "oasis/NW_elevator/CTRL/pulley_motor"
motorSpeed       = arg[3]  -- 64
modemSide        = arg[4] or "back"

elevatorGpsProtocol = elevatorProtocol.."_gps"
elevatorsJson = json.ReadJson("elevator/elevators.json")
elevatorOffset = elevatorsJson["yOffset"]

rednet.open(modemSide)
rednet.host(elevatorProtocol, "server")
-- rednet.host(elevatorGpsProtocol, "server")

cabinTransponderId = rednet.lookup(elevatorGpsProtocol, "transponder")
motor = dns.getPeripheral(motorPeripheral)

function getCabinLevel()
    rednet.send(cabinTransponderId, "request", elevatorGpsProtocol)
    resp = rednet.receive(elevatorGpsProtocol)
    return tonumber(resp[2])
end

function moveCabin(delta)
    sleep(motor.rotate(360*delta, 32))
    motor.stop()
end

function moveToPosition(yCoord) 
    currentPos = getCabinLevel()
    delta = yCoord - currentPos
    print("Moving from "..tostring(currentPos).." to "..tostring(yCoord))
    moveCabin(delta)
    newPos = getCabinLevel()
    
    while newPos ~= yCoord do
        delta = yCoord - newPos
        print("Setpoint missed, moving from "..tostring(newPos).." to "..tostring(yCoord))
        moveCabin(delta)
        newPos = getCabinLevel()
    end
end

function moveToFloor(floorLabel)
    floorLevel = tonumber(elevatorsJson[elevatorProtocol]["levels"][floorLabel])
    moveToPosition(floorLevel)
end

function sendFloorNames(receiverId)
    rednet.send(receiverId, elevatorsJson[elevatorProtocol]["levels"])
end

while true do
    senderId, message = rednet.receive(elevatorProtocol)
    print(message)
    messages = util.split(message, ";")
    if messages[1] == "request" then
        requestedFloor = tonumber(messages[2])
        moveToFloor()
    elseif messages[1] == "labels" then
        senderId = tonumber(rednetData[1])
        sendFloorNames(senderId)
    end
end