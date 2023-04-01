Channel = 'skywalkS'
HostID = 24

OutgoingPad = 'left'
IncomingPad = 'right'

local function broadcast()
    if redstone.getInput(OutgoingPad) then
        rednet.send(HostID,'outgoingOff',Channel)
    end   
    if redstone.getInput(IncomingPad) then
        rednet.send(HostID,'incomingOn',Channel)
    end
end

while true do
    broadcast()
end