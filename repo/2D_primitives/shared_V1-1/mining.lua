require('shared_V1-1/basic')
require('shared_V1-1/util')

mining = {}

-- Mines forward until there isn't a block in front of it
-- No return value
function mining.forceDig()
    while turtle.inspect() do
        turtle.dig()
    end
end

-- Mines up until there isn't a block above it
-- No return value
function mining.forceDigUp()
    while turtle.inspectUp() do
        turtle.digUp()
    end
end

-- Mines down until there isn't a block below it
-- No return value
function mining.forceDigDown()
    while turtle.inspectDown() do
        turtle.digDown()
    end
end

-- Mines the block in front of it and moves forward,
-- for specified number of steps
-- Returns success
function mining.mineForward(steps)
    basic.refuel(steps)
    local function step()
        mining.forceDig()
        return turtle.forward()
    end
    return util.repeatFunc(steps, step)
end

-- Mines the block above it and moves up,
-- for specified number of steps
-- Returns success
function mining.mineUp(steps)
    basic.refuel(steps)
    local function step()
        mining.forceDigUp()
        return turtle.up()
    end
    return util.repeatFunc(steps, step)
end

-- Mines the block below it and moves down,
-- for specified number of steps
-- Returns success
function mining.mineDown(steps)
    basic.refuel(steps)
    local function step()
        mining.forceDigDown()
        return turtle.down()
    end
    return util.repeatFunc(steps, step)
end

-- Mines tunnel according to width, height, depth
-- Each layer starts at the bottom right corner
-- Returns success
function mining.tunnel(width, height, depth)
    if not width then width = 3 end
    if not height then height = 3 end
    if not depth then depth = 1 end
    local function mineLayer()
        mining.forceDig()
        turtle.forward()
        turtle.turnLeft()
        for y = 1, (height - 1), 1 do
            mining.mineForward(width - 1)
            mining.mineUp(1)
            basic.turnAround()
        end
        mining.mineForward(width - 1)
        local odd = ((height) % 2) == 1
        if odd then -- on the left side, facing left
            basic.turnAround()
            mining.mineForward(width - 1)
            mining.mineDown(height - 1)
            turtle.turnLeft()
        else -- on the right side, facing right
            mining.mineDown(height - 1)
            turtle.turnLeft()
        end
    end
    for layer = 1, depth, 1 do
        print(layer)
        mineLayer()
    end
    basic.back(depth)
end
