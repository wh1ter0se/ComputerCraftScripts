require('shared_V1-0/basic')

-- <command> [chunks_wide] [chunks_deep]
-- starts at front right corner
MATERIAL = 'minecraft:spruce_trapdoor'
CHUNKS_WIDE = tonumber(arg[1])
CHUNKS_DEEP = tonumber(arg[2])
print('Chunks Wide: ', CHUNKS_WIDE)
print('Chunks Deep: ', CHUNKS_DEEP)
print('Material: ', MATERIAL)

-- build chunks one at a time
POS_X = 0
for cx = 1, CHUNKS_WIDE do
    -- reposition to current chunk (+ = left, deep)
    NEW_X = (cx - 1) * 16 + 1
    basic.left(NEW_X - POS_X)

    -- zigzag front/back
    for i = 1, 5 do
        for j = 1, 2 do
            if math.fmod(j, 2) == 1 then
                MOVE = basic.forward
            else
                MOVE = basic.back
            end

            for k = 1, CHUNKS_DEEP do
                for m = 1, 5 do
                    basic.selectItem(MATERIAL, 2)
                    if MOVE == basic.forward then
                        MOVE(1)
                        basic.turnAround()
                        turtle.placeDown()
                        basic.turnAround()

                        MOVE(1)
                        turtle.placeDown()

                        MOVE(1)
                    else
                        MOVE(1)
                        turtle.placeDown()

                        MOVE(1)
                        basic.turnAround()
                        turtle.placeDown()
                        basic.turnAround()

                        MOVE(1)
                    end
                end
                if k < CHUNKS_DEEP then
                    MOVE(1)
                end
            end
            basic.left(1)
        end
        basic.left(1)
    end

    -- identify new position
    POS_X = (cx) * 16
end

-- return to start position
basic.left(-POS_X)
