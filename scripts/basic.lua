require('util')

basic = {}

-- Attempts to select slot with fuel
-- Returns success
function basic.selectFuel()
    for slot = 1,16,1 do
        local selected = turtle.getItemDetail(slot)
        if selected ~= nil then
            local fuel = {'minecraft:charcoal',
                        'minecraft:coal',
                        'minecraft:coal_block',
                        'minecraft:lava_bucket'}
            if util.listContains(fuel,selected.name) then
                turtle.select(slot)
                return true
            end
        end
    end
    return false
end

-- Attempts to refuel to at least the minimum fuel level
-- Returns success
function basic.refuel(minimum)
    local oldSlot = turtle.getSelectedSlot()
    while turtle.getFuelLevel() < minimum do
        if basic.selectFuel() then
            turtle.refuel(1)
        else break end
    end
    turtle.select(oldSlot)
    return turtle.getFuelLevel() >= minimum
end

-- Attempts to consolidate partial stacks into full stacks
-- No return value
function basic.consolidate()
    local oldSlot = turtle.getSelectedSlot()
    Consolidated = true
    while not Consolidated do
        for slot = 2,16,1 do
            local selected = turtle.getItemDetail(slot)
            for prevslot = 1,slot,1 do
                local previous = turtle.getItemDetail(prevslot)
                if selected.name == previous.name then
                    turtle.transferTo(prevSlot)
                    Consolidated = false
                end
            end
        end
    end
    turtle.select(oldSlot)
end

-- Attempts to select slot with specified item name
-- Returns success 
function basic.selectItem(itemName, minimum)
    if not minimum then
        minimum = 1
    else basic.consolidate() end
    for slot = 1,16,1 do
        local selected = turtle.getItemDetail(slot)
        if selected.name == itemName and 
           selected.count >= minimum then
            turtle.select(slot)
            return true
        end
    end
    return false
end

-- Moves forward specified amount of steps
-- Returns success
function basic.forward(steps)
    basic.refuel(steps)
    return util.repeatFunc(steps, turtle.forward)
end

-- Moves back specified amount of steps
-- Returns success
function basic.back(steps)
    basic.refuel(steps)
    return util.repeatFunc(steps, turtle.back)
end

-- Moves up specified amount of steps
-- Returns success
function basic.up(steps)
    basic.refuel(steps)
    return util.repeatFunc(steps, turtle.up)
end

-- Moves down specified amount of steps
-- Returns success
function basic.down(steps)
    basic.refuel(steps)
    return util.repeatFunc(steps, turtle.down)
end

-- Strafes left specified amount of steps
-- Returns success
function basic.left(steps)
    basic.refuel(steps)
    Success = true
    turtle.turnLeft()
    Success = Success and util.repeatFunc(steps, turtle.forward)
    turtle.turnRight()
    return Success
end

-- Strafes right specified amount of steps
-- Returns success
function basic.right(steps)
    basic.refuel(steps)
    Success = true
    turtle.turnRight()
    Success = Success and util.repeatFunc(steps, turtle.forward)
    turtle.turnLeft()
    return Success
end

-- Turns right twice
-- No return value
function basic.turnAround()
    turtle.turnRight()
    turtle.turnRight()
end