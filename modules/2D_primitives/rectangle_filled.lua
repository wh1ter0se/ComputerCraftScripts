require('shared/basic')
require('shared/util')

-- <command> [blocks_wide] [blocks_deep]
-- starts at front right corner
BLOCKS_WIDE = tonumber(arg[1])
BLOCKS_DEEP = tonumber(arg[2])
MATERIAL = 'minecraft:white_concrete'
if arg[3] == '-m' or arg[3] == '-M' then
    MATERIAL = arg[4]
end
EN_UP      = util.listContains(arg, '-u') or util.listContains(arg, '-U')
EN_REPLACE = util.listContains(arg, '-r') or util.listContains(arg, '-R')

print('Blocks Wide: ', BLOCKS_WIDE)
print('Blocks Deep: ', BLOCKS_DEEP)
print('Material: ', MATERIAL)

function PLACE()
    basic.selectItem(MATERIAL, 1)
    if EN_UP then
        if EN_REPLACE then
            turtle.digUp()
        end
        turtle.placeUp()
    else
        if EN_REPLACE then
            turtle.digDown()
        end
        turtle.placeDown()
    end
end

-- zigzag front/back
POS_X = 0
POS_Y = 0
for row = 1, BLOCKS_WIDE do
    -- new direction and position for zigag
    if math.fmod(row, 2) == 1 then
        MOVE = basic.forward
        POS_Y = POS_Y + BLOCKS_DEEP
    else
        MOVE = basic.back
        POS_Y = POS_Y - BLOCKS_DEEP
    end

    -- initial block
    basic.selectItem(MATERIAL, 1)
    PLACE()

    -- build row
    basic.selectItem(MATERIAL, BLOCKS_DEEP)
    for col = 1, (BLOCKS_DEEP - 1) do
        MOVE(1)
        PLACE()
    end

    --next row
    if row < BLOCKS_WIDE then
        basic.left(1)
        POS_X = POS_X + 1
    end
end

-- return to start position
basic.left(-POS_X)
basic.forward(-POS_Y)
