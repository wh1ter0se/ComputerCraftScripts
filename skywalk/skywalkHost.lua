Motor = peripheral.wrap('bottom');

MotorSpeed = -256

OutgoingPad = 'right'
IncomingPad = 'left'

OutgoingTimer = 0
IncomingTimer = 0

MinTravelTime = 12.0; -- seconds

function enableOutgoing()

end

function disableOutgoing()

end

while true do

    if redstone.getInput(OutgoingPad) then
        OutgoingTimer = MinTravelTime;
    end   
    
    if redstone.getOutput(OutgoingPad) then
        IncomingTimer = 0
    end

    local senderId, message, protocol = rednet.receive("elevator",0.1)

end