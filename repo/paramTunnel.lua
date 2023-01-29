require('mining')

local width = tonumber(arg[1])
local height = tonumber(arg[2])
local depth = tonumber(arg[3])

mining.tunnel(width, height, depth)