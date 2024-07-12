basalt = require("shared/basalt")

gui = {}

gui.termWidth = 51
gui.termHeight = 19

function gui.monitorWidthPx(monitorWidthBlocks)
    --   7 -> 18 -> 29 -> 39 -> 50
    --       +11   +11   +10   +11
    val = 7 + (monitorWidthBlocks*11)
    if monitorWidthBlocks > 3 then
        val = val - 1
    end
    return val
end

function gui.monitorHeightPx(monitorHeightBlocks)
    --   5 -> 12 -> 19 -> 26 -> 33
    --        +7    +7    +7    +7
    return 5 + (monitorHeightBlocks*7) 
end

function gui.drawButtonGrid(frame, numRows, numCols, buttonSize, margin, labels, callback)
    for row = 0,(numRows-1) do
        for col = (numCols-1),0,-1 do
            label = labels
            x = margin*(col+1) + buttonSize[1]*(col)
            y = margin*(row+1) + buttonSize[2]*(row)
            if label ~= nil then
                print(x, y)
                button = frame:addButton()
                              :setPosition(x, y)
                              :setSize(buttonSize[1],
                                       buttonSize[2])
                              :setText(label)
                              :setForeground(colors.black)
                              :setBackground(colors.yellow)
                              :onClick(
                                  function()
                                      callback(label)
                                  end
                              )
            end
        end
    end
end

function gui.await(registers)

end

function gui.start()
    basalt.autoUpdate()
end