require("shared/dns")
os.loadAPI("shared/cryptonet")

hostname               =          arg[1]
pumpControllerHostname =          arg[2]
mouldHeight            = toNumber(arg[3])
pickSide               =          arg[4] or "left" -- "elevator_oasis_NW"



-- helpers
function buldLayer()

end

function buildFullCast()

end

function awaitMetal(metal)
    local socket = cryptoNet.connect(pumpControllerHostname)
    while socket == nil do
        socket = cryptoNet.connect(pumpControllerHostname)
    end
    cryptoNet.send(socket, {"open", metal})
    return socket
end

-- event loop
function onStart()
    cryptonet.host(hostname)

end

function onEvent(event)
   if event[1] == "encrypted_message" then
        local message = event[2]
        local socket  = event[3]
        local server  = event[4]
        if message[1] == "build" then
            success = pcall(buildFullCast)
            cryptoNet.send(socket, )
            local pumpControllerSocket = awaitMetal(awaitMetal)
        elseif message[1] == "" then
        end
   end
end

cryptoNet.startEventLoop(onStart, onEvent)