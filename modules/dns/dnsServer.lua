require("shared/util")
json = require("shared/json")
cryptonet = require("shared/cryptoNet")

modemSide = arg[1] or "back"

rednet.open(modemSide)
rednet.host("dns", "server")

peripheralsJson = json.ReadJson("dns/peripherals.json")

function getJsonValue(file, words)
    identifiers = util.split(words, "/")
    subset = file

    function recurse()
        for _, identifier in pairs(identifiers) do
            subset = subset[identifier]
        end
    end

    success = pcall(recurse)
    if success then
        return subset
    end
end

while true do
    local senderId, message = rednet.receive("dns")

    if type(message) ~= "table" then    
        print("[REQ] ")
        print(message)
        
        senderId = tonumber(senderId)
        messages = util.split(message, ";")

        if messages[1] == "peripheral" then
            resp = getJsonValue(peripheralsJson, messages[2])
            if resp ~= nil then
                rednet.send(senderId, resp, "dns")
                print("[RESP] "..resp)
            end
        end
    end
end