relayProtocol =          arg[1]  -- "oasis_power_relays"
relayName     =          arg[1]  -- "floor_1"
relaySide     =          arg[2] or "front"
modemSide     =          arg[3] or "back"

relay = peripheral.wrap(relaySide)
rednet.open(modemSide)
rednet.host(relayProtocol, relayName)

