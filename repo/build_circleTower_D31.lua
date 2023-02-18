require('shared/basic')

Layers = tonumber(arg[1])
print('Total layers:',layers)

-- Goes around the outside (CCW), in the spirit of slim shady
function QuarterRing()
    Cobble = 'minecraft:cobblestone'
    if basic.selectItem(Cobble, 21) then
        for i = 1,7 do -- 7 forward (flat side)
            turtle.placeDown()
            basic.forward(1)
        end
        
        basic.left(1) -- 3 forward
        for i = 1,3 do
            turtle.placeDown()
            basic.forward(1)
        end

        basic.left(1) -- 2 forward
        for i = 1,2 do
            turtle.placeDown()
            basic.forward(1)
        end

        basic.left(1) -- 4x 1 forward
        for i = 1,4 do
            turtle.placeDown()
            basic.forward(1)
            basic.left(1)
        end

        turtle.turnLeft() -- 2 left
        turtle.placeDown()
        basic.forward(1)
        turtle.placeDown()

        basic.right(1) -- 3 left
        for i = 1,3 do
            basic.forward(1)
            turtle.placeDown()
        end

        basic.right(1) -- return
        basic.forward(1)
        return true
    end
    return false
end

for layer = 1,layers,1 do
    print(layer)
    if turtle.detectDown() then basic.up(1) end
    for i = 1,4,1 do
        QuarterRing()
    end
end