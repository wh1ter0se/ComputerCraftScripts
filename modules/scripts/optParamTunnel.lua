require('shared/mining')

local width = tonumber(arg[1])
local height = tonumber(arg[2])
local depth = tonumber(arg[3])

SHIFT = 0
if arg[4] == '-s' or arg[4] == '-S' then
    SHIFT = tonumber(arg[5])
end

basic.refuel(64)
local displacement = 0
while turtle.forward() do
    displacement = displacement + 1
end

for i=1,depth do
    MINING.optTunnel(width, height, 1)
    basic.up(SHIFT)
    basic.forward(1)
end


basic.refuel(displacement)
basic.back(displacement)