function moveWithTransponder(axis, 
                             setpointCoord, 
                             motorPeripheralName, 
                             transponderName, 
                             motorRPM, 
                             ratio)
    local axisLookup =  {x=1, y=2, z=3}
    local axisIndex = axisLookup[axis]
    if axisIndex == nil then return end

    local oldCoord = {gps.locate()}
    local initPosition = oldCoord[axisIndex]
    local setpoint = setpointCoord[axisIndex]
    local delta = setpoint - initPosition
    
    local motor = peripheral.wrap(motorPeripheralName)
    
end