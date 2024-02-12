Json = require('json')
Server = require('Server')

MinerIds = {69, 69, 69, 69, 69}

function Listen()
    local senderId, message = rednet.receive('automine',1.0)


end

function RoleCall()
end

function Survey()
end

function NextChunk()
    local chunkCoord = nil
    local squareRing = 1
    while chunkCoord == nil do
        
    end
end

function Init()
    RoleCall()
    Survey()
end

function Iter()
    -- Update statuses
    -- Tell disabled workers to return home if waiting for command
    -- Assign new chunk to enabled workers awaiting command
end

MiningServer = Server:new(nil,'back',Init,Iter)
MiningServer:run()