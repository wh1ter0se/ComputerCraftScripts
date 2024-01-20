require('shared_V1-1/basic')
require('shared_V1-1/util')

vector = {}

DirVecs = { { name = 'y+', vec = { 0, 1, 0 } }, -- North
    { name = 'x+', vec = { 1, 0, 0 } }, -- West
    { name = 'y-', vec = { 0, -1, 0 } }, -- South
    { name = 'x-', vec = { -1, 0, 0 } }, -- East
    { name = 'z+', vec = { 0, 0, 1 } }, -- Up
    { name = 'z-', vec = { 0, 0, -1 } } } -- Down


-- The direction it starts in is treated as North
function vector.travelVec(XYZVecs, iterFunc)
    iterFunc = iterFunc or nil
    Pos = { 0, 0, 0 }
    Dir = 1 -- 1:Relative North (y+), 2:West (x+), 3:South (y-), 4:East (x-)

    for vec = 1, #XYZVecs, 1 do
        Complete = false
        local comps = { { name = 'x', val = XYZVecs[vec][1] },
            { name = 'y', val = XYZVecs[vec][2] },
            { name = 'z', val = XYZVecs[vec][3] } }
        -- sort by ascending magnitude
        table.sort(comps, function(a, b) return a.val < b.val end)

        while not Complete do
            for axis = 1, 3, 1 do
                local axisName = comps[axis].name
                local sign = util.ternary(comps[axis].val > 0, '+', '-')
                local dirIndx = util.findTableIndex(DirVecs, 'name', axisName .. sign)
                if util.listContains({ 'x', 'y' }, axisName) then -- turn
                    Dir = vector.turnToDir(Dir, dirIndx)
                end
                for step = 1, comps[axis].val, 1 do
                    local success = basic.forward(1)
                    if not success then
                        break
                    else
                        local deltaVec = DirVecs[dirIndx].vec
                        Pos = vector.add(Pos, deltaVec)
                        comps[axis].val = comps[axis].val - 1
                        if iterFunc then iterFunc(Pos) end
                        Complete = (comps[1].val == 0) and
                            (comps[2].val == 0) and
                            (comps[3].val == 0)
                    end
                end
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
    local pathAround = (4 - math.max(direction, newDirection)) + math.min(direction, newDirection)

    local pathMin = math.min(pathDirect, pathAround)

    if pathDirect < pathAround then
        Left = (newDirection < direction)                             -- no looparound
    else
        Left = (direction < newDirection)
    end                                                               -- looparound

    for i = 1, pathMin, 1 do
        if Left then
            direction = vector.turnLeft(direction)
        else
            direction = vector.turnRight(direction)
        end
    end

    return direction
end

function vector.add(vecA, vecB)
    sum = {}
    for i = 1, #vecA, 1 do
        sum[i] = vecA[i] + vecB[i]
    end
    return sum
end

-- starts at lowest X, lowest Y val
function vector.zigzagXY(funcXY, xRange, yRange)
    points = {}
    for x = xRange[1], xRange[2], 1 do
        for y = yRange[1], yRange[2], 1 do
            if funcXY(x, y) then
                table.insert(points, { x, y })
            end
        end
    end
    local minX = points[1][1]
    local minY = points[1][2]
    for pos = 2, #points, 1 do
        if points[pos][1] < minX then minX = points[pos][1] end
        if points[pos][2] < minY then minY = points[pos][2] end
    end
end
