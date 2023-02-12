require('..shared/basic')

local csv  = require("csv")

inv = {}
inv.hubToNode = (3*16)-2


function inv.findItem(itemName)
    chests = {}
    for node = 1,3,1 do
        local Register = csv.open('register' .. node .. '.csv')


        --table.insert(chests, {node,{alley,col,row,left},quantity})
    end
end

function inv.store(itemName)

end

function inv.retrieve(itemName)

end

-- Goes to specified chest position
function inv.goTo(alley, col, row, left)
    basic.forward(inv.hubToNode) -- Enter inventory node

    basic.right(alley*2) -- Go to alley
    basic.forward(col*2) -- Go down alley, to column

    local heightDelta = row - 4
    basic.up(heightDelta) -- Move to correct row height

    if left then turtle.turnLeft()
    else turtle.turnRight() end -- Turn toward chest
end

-- Returns to base position from specified chest
function inv.returnHome(alley, col, row, left)
    if left then turtle.turnRight()
    else turtle.turnLeft() end -- Turn away from chest

    local heightDelta = row - 4
    basic.down(heightDelta) -- Move back to rail height

    basic.back(col*2) -- Exit the alley
    basic.left(alley*2) -- Return to the center

    basic.back(inv.hubToNode) -- Return to inventory node
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