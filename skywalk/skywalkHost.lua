Motor = peripheral.wrap('bottom');

Channel = 'skywalkS'

MotorSpeed = -255

OutgoingPad = 'right'
IncomingPad = 'left'

OutgoingTimerEnd = 0
IncomingTimerEnd = 0

MinTravelTime = 12.0; -- seconds

local function seconds() -- float value
    return os.time() * 50
end

CurrTime = seconds()
RunTime = 0

local function updateTime()
    local newTime = seconds()
    local timeDelta = newTime - CurrTime
    if timeDelta < 0 then timeDelta = timeDelta + 2400
    CurrTime = newTime 
    RunTime = RunTime + timeDelta
end

local function listen()
    local senderId, message, protocol = rednet.receive(Channel,0.01)
    if message == 'outgoingOff' then
        OutgoingTimerEnd = RunTime
    elseif message == 'incomingOn' then
        IncomingTimerEnd = RunTime + MinTravelTime
    end
end

while true do
    updateTime()
    listen()

    if redstone.getInput(OutgoingPad) then
        OutgoingTimerEnd = RunTime + MinTravelTime
    end   
    if redstone.getInput(IncomingPad) then
        IncomingTimerEnd = RunTime
    end

    if OutgoingTimerEnd > RunTime or IncomingTimerEnd > Runtime then
        Motor.setSpeed(MotorSpeed)
    else
        Motor.setSpeed(0)
    end
end