Server = {side = 'back',
          initFunc = function () end,
          iterFunc = function () return 1 end,
          ignoreStatus = false}

function Server:new(o,side,initFunc,iterFunc,ignoreControl,ignoreStatus)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.side = side or "back"
    self.initFunc = initFunc or function () end
    self.iterFunc = iterFunc or function () return 0 end
    self.ignoreControl = ignoreControl or false
    self.ignoreStatus = ignoreStatus or false
    return o
 end

function Server:statusUpdate(statusCode)
    if not self.ignoreStatus then
        local statusServerId = rednet.lookup('status','host')
        rednet.send(statusServerId, str(statusCode), 'status')
    end
end

function Server:checkEnabled()
    local controlServerId = rednet.lookup('control','host')
    rednet.send()
end

function Server:update()
    local status = self.iterFunc()
    self:statusUpdate(status)
end

function Server:run()
    self.initFunc()
    local terminated = false
    while not terminated do 
        local success, statusCode = pcall(self.update())
        if not success and statusCode == 'Terminated' then
            terminated = true
            print('Terminated')
        elseif not success then
            self:statusUpdate(-1)
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