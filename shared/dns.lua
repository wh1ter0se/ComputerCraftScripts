dns = {}

-- Retrieves and wraps a peripheral name provided by DNS
-- Returns peripheral object
function dns.getPeripheral(label)
    if not rednet.isOpen() then
        error("No rednet modem found")
    end
    dnsServer = rednet.lookup("dns", "server")
    -- rednet.send(dnsServer, "peripheral;"..label, "dns")
    message = nil
    retryCount = 0
    maxRetries = 2
    while message == nil do
        rednet.send(dnsServer, "peripheral;"..label, "dns")
        senderId, message = rednet.receive("dns", 5)
        if message == nil then
            print("Could not find peripheral name of \""..label.."\", retrying... ("..tostring(retryCount)..")")
            retryCount = retryCount + 1
        end
    end
    print("Found peripheral \""..label.."\" ("..message..")")
    return peripheral.wrap(message)
end

function dns.getPeripheralList(label)
    
end