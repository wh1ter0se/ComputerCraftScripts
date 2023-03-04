rednet.open('back')

Delta = tonumber(arg[1])
ElevatorID = 14

rednet.send(ElevatorID,'move;'..Delta,'elevator')
