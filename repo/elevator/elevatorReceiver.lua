require('util')

rednet.open('top')

Floor = tonumber(arg[1])
Floors = {80,  -- Upper Exit
          199, -- Chamfer
          212, -- Skydeck
          224, -- Guest Lounge
          234, -- Hangar
          290, -- Generator
          300} -- Penthouse

Motor = peripheral.wrap("left")

MotorSpeed = 128
DegreesPerBlock = 152.5

while true do
    local senderId, message, protocol = rednet.receive("elevator")
    local words = util.split(message,';')
    if words[1] == 'delta' then
        Move(tonumber(words[2]))
    elseif words[2] == 'floor' then
        
    end
end

function Move(delta)
    local speed = MotorSpeed
    if delta < 0 then speed = -speed end
    print('Starting Motor (delta = ' .. delta .. ')')
    motor.setSpeed(speed)
    sleep(motor.rotate(delta*DegreesPerBlocks,speed))
    motor.stop()
    print('Stopping Motor')
end

function MoveToFloor(delta)

end