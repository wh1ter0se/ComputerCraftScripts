rednet.open('back')

elevatorProtocol = arg[1]  -- "elevator_oasis_NW"
elevatorGpsProtocol = elevatorProtocol.."_gps"

rednet.open(modemSide)
rednet.host(elevatorGpsProtocol, "transponder")

while true do
    rednetData = rednet.receive(elevatorGpsProtocol)
    x, y, z = gps.locate()
    if rednetData[2] == "request" then
        senderId = rednetData[1]
        rednet.send(senderId, y, elevatorGpsProtocol)
    end
end