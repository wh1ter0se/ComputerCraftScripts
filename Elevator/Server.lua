Json = require('json')
Server = require('Server')

function MoveElevator(shaftName, delta)
    local controllerId = rednet.lookup('elevator',shaftName)
    rednet.send(controllerId, 'delta;'..delta,'elevator')
end

function ReadJson(shaftName)
    local file = io.open(shaftName..'.json', 'r')
    local jsonStr = file:read('*a')
    file:close()
    return Json.decode(jsonStr)
end

function SetFloor(shaftName,floor)
    local jsonArr = ReadJson(shaftname)
    jsonArr[shaftname]['currFloor'] = floor
    local file = io.open(shaftName..'.json', 'w')
    file:write(Json.encode(jsonArr))
    file:close()
end

function Init()
    print('Elevator Server Started')
end

function Iter()
    local senderId, message = rednet.receive('elevator',1.0)
    local Status = 0 -- no activity
    if message ~= nil then
        local words = Server.splitMessage(message,';')
        local shaftName = words[1]
        local command = words[2]
        local value = tonumber(words[3]) or 0

        local currentFloor = ReadJson(shaftName)['currFloor']
        local floors = ReadJson(shaftName)['floors']
        if command == 'delta' then
            rednet.send(senderId,'Confirmed','elevator')
            MoveElevator(shaftName,value)
            Status = 2 -- delta requested
        elseif command == 'setFloor' then
            rednet.send(senderId,'Confirmed','elevator')
            SetFloor(shaftName,value)
            local currHeight = floors[currentFloor]['height']
            local newHeight = floors[value]['height']
            local delta = newHeight - currHeight;
            MoveElevator(shaftName, delta)
            Status = 3 -- set floor requested
        elseif command == 'requestFloors' then
            rednet.send(senderId,floors,'elevator')
            Status = 4 -- list of floors requested
        elseif command == 'requestHeight' then
            rednet.send(senderId,floors[currentFloor]['height'],'elevator')
            Status = 5 -- current height requested
        end
        Status = 1 -- unknown command
    end
    return Status
end

local elevatorServer = Server:new('back',Init,Iter)
elevatorServer:run()