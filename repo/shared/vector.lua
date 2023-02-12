require('..shared/basic')
require('..shared/util')

vector = {}

DirVecs = {{name='y+', vec={0,1,0}}, -- North
           {name='x+', vec={1,0,0}}, -- West
           {name='y-', vec={0,1,0}}, -- South
           {name='x-', vec={0,1,0}}} -- East

-- The direction it starts in is treated as North
function vector.funcByVector(XYZVecs, iterFunc)
    Pos = {0,0,0}
    Dir = 1 -- 1:Relative North (y+), 2:West (x+), 3:South (y-), 4:East (x-)

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

function vector.turnLeft(direction)
    turtle.turnLeft()
    direction = direction - 1
    if direction < 1 then direction = 4 end
    return direction
end

function vector.turnRight(direction)
    turtle.turnRight()
    direction = direction + 1
    if direction > 4 then direction = 1 end
    return direction
end

function vector.turnToDir(direction, newDirection)
    if direction == newDirection then return direction end
    local pathDirect = math.abs(newDirection - direction)
    local pathAround = (4-max(direction,newDirection)) + min(direction,newDirection)

    --local pathMin = min(pathDirect, pathAround)

    if pathDirect < pathAround then -- no looparound
        if newDirection < direction then -- newDir left of dir
            for i=1,pathDirect,1 do
                direction = vector.turnLeft(direction)
            end
        else -- newDir right of dir
            for i=1,pathDirect,1 do
                direction = vector.turnRight(direction)
            end
        end
    else -- looparound
        if direction < newDirection then -- newDir left of dir
            for i=1,pathAround,1 do
                direction = vector.turnLeft(direction)
            end
        else -- newDir right of dir
            for i=1,pathAround,1 do
                direction = vector.turnRight(direction)
            end
        end
    end

    return direction
end

function vector.add(vecA, vecB)
    sum = {}
    for i = 1,#vecA,1 do
        sum[i] = vecA[i] + vecB[i]
    end
    return sum
end