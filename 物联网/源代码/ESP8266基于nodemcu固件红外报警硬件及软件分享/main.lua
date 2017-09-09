--read config file
dofile("conf.lua")
--read end
--config pins
gpio.mode(conf.LED,gpio.OUTPUT)
gpio.mode(conf.BUZZER,gpio.OUTPUT)
gpio.mode(conf.INFRARED,gpio.INT)
trig = gpio.trig
--config end
--connect bigiot
cu = net.createConnection(net.TCP)
cu:connect(conf.PORT, conf.HOST)
--connect end
dofile("keepOnline.lua")
dofile("receive.lua")
dofile("trig.lua")