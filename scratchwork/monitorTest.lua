monitor = peripheral.wrap("monitor_6")

term.redirect(monitor)
-- monitor.setCursorPos(1, 1)
-- monitor.write("Hello, world!")
monitor.clear()
paintutils.drawBox(0, 0, 5, 5, colors.red)