require('shared/basic')
require('shared/util')

MINING = {}

-- Mines forward until there isn't a block in front of it
-- No return value
function MINING.forceDig()
    while turtle.inspect() do
        turtle.dig()
    end
end

-- Mines up until there isn't a block above it
-- No return value
function MINING.forceDigUp()
    while turtle.inspectUp() do
        turtle.digUp()
    end
end

-- Mines down until there isn't a block below it
-- No return value
function MINING.forceDigDown()
    while turtle.inspectDown() do
        turtle.digDown()
    end
end

-- Mines the block in front of it and moves forward,
-- for specified number of steps
-- Returns success
function MINING.mineForward(steps)
    basic.refuel(steps)
    local function step()
        MINING.forceDig()
        return turtle.forward()
    end
    return util.repeatFunc(steps, step)
end

-- Mines the block above it and moves up,
-- for specified number of steps
-- Returns success
function MINING.mineUp(steps)
    basic.refuel(steps)
    local function step()
        MINING.forceDigUp()
        return turtle.up()
    end
    return util.repeatFunc(steps, step)
end

-- Mines the block below it and moves down,
-- for specified number of steps
-- Returns success
function MINING.mineDown(steps)
    basic.refuel(steps)
    local function step()
        MINING.forceDigDown()
        return turtle.down()
    end
    return util.repeatFunc(steps, step)
end

-- Mines tunnel according to width, height, depth
-- Each layer starts at the bottom right corner
-- Returns success
function MINING.tunnel(width, height, depth)
    if not width then width = 3 end
    if not height then height = 3 end
    if not depth then depth = 1 end
    local function mineLayer()
        MINING.forceDig()
        turtle.forward()
        turtle.turnLeft()
        for y = 1, (height - 1), 1 do
            MINING.mineForward(width - 1)
            MINING.mineUp(1)
            basic.turnAround()
        end
        MINING.mineForward(width - 1)
        local odd = ((height) % 2) == 1
        if odd then -- on the left side, facing left
            basic.turnAround()
            MINING.mineForward(width - 1)
            MINING.mineDown(height - 1)
            turtle.turnLeft()
        else -- on the right side, facing right
            MINING.mineDown(height - 1)
            turtle.turnLeft()
        end
    end
    for layer = 1, depth, 1 do
        print(layer)
        mineLayer()
    end
    basic.back(depth)
end
