os.loadAPI("shared/cryptoNet")

comms = {}

function comms.check()
    if not rednet.isOpen() then
        print("No rednet modem found")
        return false
    end
    return true
end

function comms.awaitAck(receiverId, message, protocol, timeout, maxRetries))
    reattempts = 0
    while (reattempts < maxRetries) or (maxRetries == 0) do
        rednetData = {rednet.receive(protocol, timeout)}
        if rednetData == nil then
            rednet.send(receiverId, message, protocol)
        elseif rednetData[1] == message[1] then
            if     rednetData[2] == "ack" then
                return true
            elseif rednetData[2] == "nack" then
                return false
            end
        end
    end
    return false
end

function comms.sendRequest(receiverId, messageId, packet, protocol, timeout, maxRetries)
    if not comms.check() then
        return
    end
    timeout = timeout or 1
    maxRetries = maxRetries or 0
    message = {messageId, "req", packet}
    rednet.send(receiverId, message, protocol, timeout)

    
end

function comms.awaitRequest(messageId, protocol, timeout, maxRetries)
    if not comms.check() then
        return
    end
    timeout = timeout or 1
    maxRetries = maxRetries or 0

    rednetData = {rednet.receive(protocol, timeout)}

    while not (rednetData[1] == messageId and
               rednetData[2] == "resp") do
                
               end
    end
end


function comms.sendResponse(receiverId, packetId, value, protocol)
    if not rednet.isOpen() then
        print("No rednet modem found")
        return
    end
    rednet.send(receiverId, {"req", packetId, value}, protocol)
end

function awaitResponse