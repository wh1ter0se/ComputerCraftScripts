Server = {}

function Server:new(o,side,initFunc,iterFunc,ignoreStatus)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.side = side or "back"
    self.initFunc = initFunc or function () end
    self.iterFunc = iterFunc or function () return 0 end
    self.ignoreStatus = ignoreStatus or false
    return o
 end

function Server:statusUpdate(statusCode)
    local statusServerId = rednet.lookup('status','host')
    rednet.send(statusServerId, str(statusCode), 'status')
end

function Server:update()
    local status = self.iterFunc()
    if not self.ignoreStatus then
        self.statusUpdate(status)
    end
end

function Server:run()
    self.initFunc()
    local terminated = false
    while not terminated do 
        local success, statusCode = pcall(self.update())
        if not success and statusCode == 'Terminated' then
            terminated = true
            print('Terminated')
        end
    end
end

function Server.splitMessage(message, delimiter)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end