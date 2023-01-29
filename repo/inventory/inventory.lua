require('..shared/basic')

local Csv  = require("csv.lua")
local Register = Csv.open('register.CSV')

inv = {}
inv.hubToNode = (3*16)-2

function inv.store(itemName)

end

function inv.retrieve(itemName)

end

-- Goes to specified chest position
function inv.goTo(alley, col, row, left)
    basic.forward(inv.hubToNode)
    basic.left(alley*2)
    if col > 0 then -- positive col
        basic.forward(col*2)
    else -- negative col
        basic.back(col*2)
    end
    local heightDelta = row - 4

    if heightDelta < 0 then basic.down(-heightDelta)
    elseif heightDelta > 0 then basic.up(heightDelta) end

    if left then turtle.turnLeft()
    else turtle.turnRight() end
end

-- Returns to base position from specified chest
function inv.returnHome(alley, col, row, left)

end

-- Creates a new chest, in the closest available location
function newChest(itemName)
    
end

-- Checks for open, unallocated chest and allocates it
function allocateChest(itemName)
    
end

-- Removes empty chest from the register
function deallocateChest(itemName)
    
end