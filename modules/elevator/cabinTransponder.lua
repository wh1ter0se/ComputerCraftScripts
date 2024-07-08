rednet.open('back')

elevatorProtocol = arg[1]  -- "elevator_oasis_NW"
modemSide        = arg[2] or "back"
elevatorGpsProtocol = elevatorProtocol.."_gps"

rednet.open(modemSide)
rednet.host(elevatorGpsProtocol, "transponder")

while true do
    senderId, message = rednet.receive(elevatorGpsProtocol)
    x, y, z = gps.locate()
    if message == "request" then
        print("Sending coordinates ["..tostring(x)..", "..tostring(y)..", "..tostring(z).."]")
        rednet.send(senderId, y, elevatorGpsProtocol)
    end
end