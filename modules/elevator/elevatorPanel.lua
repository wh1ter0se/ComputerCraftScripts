require("shared/gui")

elevatorProtocol =          arg[1]  -- "elevator_oasis_NW"
numCols          = tonumber(arg[2]) -- 2
monitorSide      =          arg[3] or "top"
modemSide        =          arg[4] or "bottom"

rednet.open(modemSide)
monitor = peripheral.wrap(monitorSide)
elevatorServerId = rednet.lookup(elevatorProtocol, "server")


function getCurrentFloor()
    rednet.send(elevatorServerId, "currentFloor;", elevatorProtocol)
    return rednet.receive(elevatorProtocol)
end

function getFloorData()
    -- rednet.send(elevatorServerId, "floorData;", elevatorProtocol)
    -- return rednet.receive(elevatorProtocol)
    return {["L3"]={}, ["L2"]={}, ["L1"]={}, ["L"]={}, ["B1"]={}}
end

function drawInterface(currentFloor, floorData, numCols)
    floors = {}
    for key, val in pairs(floorData) do
        floors[#floors+1] = key
    end
    print(#floorData)
    print(math.ceil(#floorData))
    w, h = term.getSize()
    mainframe = basalt.addMonitor()
    mainframe:setMonitor(monitorSide)
    function callback(buttonLabel)
        rednet.send(elevatorServerId, "request;"..buttonLabel, elevatorProtocol)
    end
    titlebar = mainframe:addFrame()
                        :setSize(w, 1)
                        :setPosition(1, 1)
                        :setForeground(colors.white)
                        :setBackground(colors.black)
    panel = mainframe:addFrame()
                     :setSize(w, h-1)
                     :setPosition(1, 2)
                     :setBackground(colors.gray)

    titlebar:addLabel()
            :setText(currentFloor):setPosition(3,1)
            :setForeground(colors.white)
            :setBackground(colors.black)
    gui.drawButtonGrid{
        frame      = panel,
        numRows    = math.ceil(#floorData/numCols),
        numCols    = numCols,
        buttonSize = {2,1},
        margin     = 1,
        labels     = floors,
        callback   = callback
    }
    -- panel:addButton()
    --      :setPosition(2, 2)
    --      :setSize(2, 1)
    --      :setText("L2")
    --      :setForeground(colors.black)
    --      :setBackground(colors.yellow)
    --      :onClick(
    --         function()
    --             callback(label)
    --         end
    --      )

    -- panel:addButton()
    --      :setPosition(2, 2)
    --      :setSize("parent.", 1)
    --      :setText("L2")
    --      :setForeground(colors.black)
    --      :setBackground(colors.yellow)
    --      :onClick(
    --         function()
    --             callback(label)
    --         end
    --      )
end


-- term.redirect(monitor)
-- term.setBackgroundColor(colors.black)
-- term.clear()
currentFloor = getCurrentFloor()
basalt.debug("currentFloor:")
basalt.debug(currentFloor)
floorData = getFloorData()
basalt.debug("floorData:")
basalt.debug(floorData)
drawInterface(currentFloor, floorData, 2)

while true do
    basalt.autoUpdate()
end
