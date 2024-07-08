require("shared/gui")
basalt = require("shared/basalt")

elevatorProtocol =          arg[1]  -- "elevator_oasis_NW"
numCols          = tonumber(arg[2]) -- 2
modemSide        =          arg[3] or "left"

elevatorServerId = rednet.lookup(elevatorProtocol, "server")

function getCurrentFloor()
    rednet.send(elevatorServerId, "currentFloor;", elevatorProtocol)
end

function getFloorData()
    rednet.send(elevatorServerId, "floorData;", elevatorProtocol)
end

function drawInterface(currentFloor, floorData, numCols)
    floors = {}
    for key, val in pairs(floorData) do
        floors[#floors+1] = key
    end

    function callback(buttonLabel)
        rednet.send(elevatorServerId, "request;"..buttonLabel, elevatorProtocol)
    end

    mainframe = basalt.createFrame()
    titlebar = mainframe:addFrame()
                        :setSize("parent.w", 1)
                     :setPosition(1, 1)
    panel = mainframe:addFrame()
                     :setSize("parent.w", 1)
                     :setPosition(1, 2)

    titlebar:addLabel()
            :setText(currentFloor):setPosition(1,1)
    gui.drawButtonGrid{
        frame    = mainframe,
        numRows  = math.ceil(#floorData/numCols),
        numCols  = numCols,
        margin   = 0.5,
        labels   = floors,
        callback = callback
    }
end

currentFloor = getCurrentFloor()
floorData = getFloorData()
drawInterface(currentFloor, floorData, numCols)
basalt.autoUpdate()

