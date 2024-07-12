require("shared/dns")
require("shared/util")
json = require("shared/json")

elevatorProtocol =          arg[1]  -- "elevator_oasis_NW"
motorPeripheral  =          arg[2]  -- "oasis/NW_elevator/CTRL/pulley_motor"
motorSpeed       = tonumber(arg[3])  -- 64
modemSide        =          arg[4] or "back"

elevatorGpsProtocol = elevatorProtocol.."_gps"
elevatorInfoProtocol = elevatorProtocol.."_info"
elevatorsJson = json.ReadJson("elevator/elevators.json")
elevatorOffset = elevatorsJson[elevatorProtocol]["yOffset"]

rednet.open(modemSide)
rednet.host(elevatorProtocol, "server")
rednet.host(elevatorGpsProtocol, "server")

cabinTransponderId = rednet.lookup(elevatorGpsProtocol, "transponder")
motor = dns.getPeripheral(motorPeripheral)

currentFloor = "N/A"

function log(message)
    print("[BROADCAST] "..message)
    rednet.broadcast(message, elevatorInfoProtocol)
end

function getCabinLevel()
    resp = nil
    while resp == nil do
        rednet.send(cabinTransponderId, "request", elevatorGpsProtocol)
        _, resp = rednet.receive(elevatorGpsProtocol, 0.1)
    end
    return tonumber(resp)
end

function moveCabin(delta)
    sleep(motor.translate(delta, motorSpeed))
    motor.stop()
end

function moveToPosition(yCoord) 
    currentPos = getCabinLevel()
    delta = yCoord - currentPos
    if delta == 0 then
        log("Elevator already at setpoint")
        return
    end
    log("Moving from "..tostring(currentPos).." to "..tostring(yCoord))
    moveCabin(delta)
    newPos = getCabinLevel()
    
    while newPos ~= yCoord do
        delta = yCoord - newPos
        log("Setpoint missed, moving from "..tostring(newPos).." to "..tostring(yCoord))
        moveCabin(delta)
        newPos = getCabinLevel()
    end
end

function moveToFloor(floorSlug)
    floorLevel = elevatorsJson[elevatorProtocol]["levels"][floorSlug]["yCoord"]
    floorLabel = elevatorsJson[elevatorProtocol]["levels"][floorSlug]["fullLabel"]
    log("Elevator requested to "..floorLabel)

    if floorLevel == nil then
        log("Invalid floor slug: \""..floorSlug.."\"")
        return
    end
    floorLevel = floorLevel + elevatorOffset
    moveToPosition(floorLevel)
    currentFloor = floorSlug
    log("Elevator arrived at "..floorLabel)
end

function sendCurrentFloor(receiverId)
    rednet.send(receiverId, {"currentFloor", "resp", currentFloor}, elevatorProtocol)
    print("[INFO] Sending current floor: "..currentFloor)
end

function sendFloorData(receiverId)
    floorData = {"floorData", "resp", elevatorsJson[elevatorProtocol]["levels"]}
    rednet.send(receiverId, floorData, elevatorProtocol)
    print("[INFO] Sending floor data: ")
    print(floorData)
end

while true do
    senderId, message = rednet.receive(elevatorProtocol)
    print("[RECEIVED]"..message)
    messages = util.split(message, ";")
    if messages[1] == "request" then
        print("[INFO] Processing move request...")
        requestedFloor = messages[2]
        moveToFloor(requestedFloor)
    elseif messages[1] == "currentFloor" then
        print("[INFO] Processing currentFloor request...")
        sendCurrentFloor(senderId)
    elseif messages[1] == "floorData" then
        print("[INFO] Processing floorData request...")
        sendFloorData(senderId)
    end
end