redrouter_left = peripheral.wrap("left")
redrouter_right = peripheral.wrap("right")
redrouter_aux = peripheral.wrap("redrouter_19")

motor = peripheral.wrap("electric_motor_40")

speed = 32

function checkInput(dir)
    if     dir == "up" then
        return redrouter_left.getInput("right")
    elseif dir == "down" then
        return redrouter_left.getInput("back")
    elseif dir == "left" then
        return redrouter_left.getInput("left")
    elseif dir == "right" then
        return redrouter_right.getInput("right")
    elseif dir == "back" then
        return redrouter_right.getInput("back")
    elseif dir == "forward" then
        return redrouter_right.getInput("left")
    end
end

function setMode(mode)
    if     mode == "x" then
        redrouter_aux.setOutput("right", true)  -- red
        redrouter_aux.setOutput("left", false)  -- blue
    elseif mode == "y" then
        redrouter_aux.setOutput("right", true)  -- red
        redrouter_aux.setOutput("left", true)   -- blue
    elseif mode == "z" then
        redrouter_aux.setOutput("right", false) -- red
        redrouter_aux.setOutput("left", false)  -- blue
    elseif mode == "reset" then
        redrouter_aux.setOutput("right", false) -- red
        redrouter_aux.setOutput("left", false)  -- blue
    end
    sleep(.5)
end

function handleInput()
    function handleDir(dir, axis, scalar)
        if checkInput(dir) then
            print(dir)
            setMode(axis)
            motor.setSpeed(scalar*speed)
            while checkInput(dir) do
                sleep(.1)
            end
            motor.stop()
            sleep(.2)
            setMode("reset")
        end
    end

    if handleDir("up",      "y",  1) or
       handleDir("down",    "y", -1) or
       handleDir("left",    "x",  1) or
       handleDir("right",   "x", -1) or
       handleDir("back",    "z",  1) or
       handleDir("forward", "z", -1) then
        sleep(.2)
    -- if     checkInput("up") then
    --     print("up")
    --     setMode("y")
    --     motor.setSpeed(speed)

    -- elseif checkInput("down") then
    --     print("down")
    --     setMode("y")
    --     motor.setSpeed(-speed)

    -- elseif checkInput("left") then
    --     print("left")
    --     setMode("x")
    --     motor.setSpeed(speed)

    -- elseif checkInput("right") then
    --     print("right")
    --     setMode("x")
    --     motor.setSpeed(-speed)

    -- elseif checkInput("back") then
    --     print("back")
    --     setMode("z")
    --     motor.setSpeed(speed)

    -- elseif checkInput("forward") then
    --     print("forward")
    --     setMode("z")
    --     motor.setSpeed(-speed)
    else
        motor.stop()
        setMode("reset")
        sleep(.1)
    end
end

while true do
    handleInput()
end