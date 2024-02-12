require('shared_V1-0/basic')

-- <command> [chunks_wide] [chunks_deep]
-- starts at front right corner
MATERIAL = 'minecraft:cobblestone'
CHUNKS_WIDE = tonumber(arg[1])
CHUNKS_DEEP = tonumber(arg[2])
OUTLINE = tonumber(arg[3])
print('Chunks Wide: ', CHUNKS_WIDE)
print('Chunks Deep: ', CHUNKS_DEEP)
print('Material: ', MATERIAL)


-- outline
if OUTLINE then
    for i = 1, 2 do
        -- deep edge
        basic.selectItem(MATERIAL, (2 * 16 * (CHUNKS_DEEP - 1)))
        for j = 1, (16 * CHUNKS_DEEP - 1) do
            basic.forward(1)
            turtle.placeDown()
        end
        turtle.turnLeft()

        -- wide edge
        basic.selectItem(MATERIAL, (2 * 16 * (CHUNKS_WIDE - 1)))
        for j = 1, (16 * CHUNKS_WIDE - 1) do
            basic.forward(1)
            turtle.placeDown()
        end
        turtle.turnLeft()
    end
end


-- build chunks one at a time
POS_X = 0
POS_Y = 0
for cx = 1, CHUNKS_WIDE do
    for cy = 1, CHUNKS_DEEP do
        -- reposition to current chunk (+ = left, deep)
        NEW_X = (cx - 1) * 16
        new_y = (cy - 1) * 16
        basic.left(NEW_X - POS_X)
        basic.forward(new_y - POS_Y)

        -- chunk outline
        for i = 1, 2 do
            -- deep edge
            basic.selectItem(MATERIAL, 15)
            for j = 1, 15 do
                basic.forward(1)
                turtle.placeDown()
            end
            turtle.turnLeft()

            -- wide edge
            basic.selectItem(MATERIAL, 15)
            for j = 1, 15 do
                basic.forward(1)
                turtle.placeDown()
            end
            turtle.turnLeft()
        end

        -- zigzag front/back
        for i = 1, 4 do
            basic.left(3)
            if math.fmod(i, 2) == 1 then
                MOVE = basic.forward
            else
                MOVE = basic.back
            end

            basic.selectItem(MATERIAL, 14)
            for j = 1, 15 do
                MOVE(1)
                turtle.placeDown()
            end
        end

        -- zigzag left/right
        basic.left(3)
        turtle.turnRight()
        for j = 1, 4 do
            basic.left(3)
            if math.fmod(j, 2) == 1 then
                MOVE = basic.forward
            else
                MOVE = basic.back
            end

            basic.selectItem(MATERIAL, 14)
            for j = 1, 15 do
                MOVE(1)
                turtle.placeDown()
            end
        end
        turtle.turnLeft()

        -- identify new position
        POS_X = (cx - 1) * 16 + 15
        POS_Y = (cy - 1) * 16 + 12
    end
end

-- return to start position
basic.left(-POS_X)
basic.forward(-POS_Y)
