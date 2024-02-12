require('shared_V1-1/mining')

local width = tonumber(arg[1])
local height = tonumber(arg[2])
local depth = tonumber(arg[3])

basic.refuel(64)
local displacement = 0
while turtle.forward() do
    displacement = displacement + 1
end

MINING.optTunnel(width, height, depth)

basic.refuel(displacement)
basic.back(displacement)