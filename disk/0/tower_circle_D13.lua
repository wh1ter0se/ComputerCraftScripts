layers = tonumber(arg[1])
print('Total layers:',layers)

function refill(minimum)
    fuelLevel = turtle.getFuelLevel()
    oldSlot = turtle.getSelectedSlot()
    turtle.select(16)
    while fuelLevel < minimum do
        turtle.refuel(1)
    end
    turtle.select(oldSlot)
end

function getMaterial(amount,first,last)
    for slot = first,last,1 do
        turtle.select(slot)
        stock = turtle.getItemCount()
        if stock >= amount then 
            return true
        end
    end    
    return false    
end

function getCobble(amount)
    return getMaterial(amount,1,15)
end

-- Goes CCW, completing 1/4 of the ring
function quarterRing()
    if getCobble(9) then
        for i = 1,5,1 do
            turtle.placeDown()
            turtle.forward()
        end
        turtle.turnLeft()
        turtle.forward()
        turtle.turnRight()
        for i = 1,2,1 do
            turtle.placeDown()
            turtle.forward()
        end
        turtle.turnLeft()
        turtle.forward()
        for i = 1,2,1 do
            turtle.placeDown()
            turtle.forward()
        end
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
    end
end

for layer = 1,layers,1 do
    print(layer)
    refill(16)
    if turtle.detectDown() then
        turtle.up()
    end
    for i = 1,4,1 do
        quarterRing()    
    end
    
end
