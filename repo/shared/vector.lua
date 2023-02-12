require('..shared/basic')
require('..shared/util')

vector = {}

-- The direction it starts in is treated as North
function vector.funcPattern(XYZVecs, iterFunc)
    Pos = {0,0,0}
    Dir = 1 -- 1:Relative North (y+), 2:West (x+), 3:South (y-), 4:East (x-)
    local dirVecs = {{name='y+', vec={0,1,0}}, -- North
                     {name='x+', vec={1,0,0}}, -- West
                     {name='y-', vec={0,1,0}}, -- South
                     {name='x-', vec={0,1,0}}} -- East
    local function turnLeft()
        turtle.turnLeft()
        Dir = Dir - 1
        if Dir < 1 then Dir = 4 end
    end
    local function turnRight()
        turtle.turnRight()
        Dir = Dir + 1
        if Dir > 4 then Dir = 1 end
    end

    for i = 1,#XYZVecs,1 do
        local comps = {{name='x', val=XYZVecs[i][1], },
                       {name='y', val=XYZVecs[i][2]},
                       {name='z', val=XYZVecs[i][3]}}
        -- sort by ascending magnitude
        table.sort(comps, function(a,b) return a.val < b.val end)
        for axis = 1,3,1 do
            local axisName = comps[axis].name
            if util.listContains({'x','y'},axisName) and
               not string.find(dirVecs[Dir].name,axisName) then
                turnRight()
            end
        end
    end
end

