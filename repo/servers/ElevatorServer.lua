Server = require('Server')

function init()
    print('Elevator Server Started')
end

function iter()
    local senderId, message = rednet.receive('elevator',1.0)
    if message ~= nil then
        local words = Server.splitMessage(message,';')
        if words[1] == 'delta' then
            
        elseif words[1] == 'setFloor' then

        elseif words[1] == 'requestFloors' then

        elseif words[1] == 'requestHeight' then

        end
        return 1
    else
        return 0
    end
end

elevatorServer = Server:new('back',init,iter)