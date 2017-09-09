--trig begin
local function trigAlarm(level)
	if level == gpio.HIGH then
		conf.STATUS = 1
		gpio.write(conf.LED, gpio.HIGH)
		if conf.OFFON == 1 then
			gpio.write(conf.BUZZER, gpio.HIGH)
		end		
		local v = {[conf.INPUTID] = "1"}
		ok3, s3 = pcall(cjson.encode, {M="update",ID=conf.DEVICEID,V=v})
		if ok3 then
		  print(s3)
		  cu:send( s3.."\n" )
		else
		  print("failed to encode 3 !")
		end
	else
		conf.STATUS = 0
		gpio.write(conf.LED, gpio.LOW)
		gpio.write(conf.BUZZER, gpio.LOW)
		local v = {[conf.INPUTID] = "0"}
		ok5, s5 = pcall(cjson.encode, {M="update",ID=conf.DEVICEID,V=v})
		if ok5 then
		  print(s5)
		  cu:send( s5.."\n" )
		else
		  print("failed to encode 5 !")
		end
	end
end
trig(conf.INFRARED, "both", trigAlarm)
--trig end