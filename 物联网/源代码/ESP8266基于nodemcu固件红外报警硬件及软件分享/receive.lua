--receive message from bigiot
cu:on("receive", function(cu, c) 
	print(c)
	--do something here
	r = cjson.decode(c)
	if r.M == "checkinok" then
		tmr.interval(1, 50000)
	end
	if r.M == "say" then
		if r.C == "play" then
			--gpio.write(conf.LED, gpio.HIGH)
			--gpio.write(conf.BUZZER, gpio.HIGH)
			conf.OFFON = 1
			ok, begin = pcall(cjson.encode, {M="say",ID=r.ID,C="Start monitoring"})
			cu:send( begin.."\n" )
		end
		if r.C == "stop" then
			--gpio.write(conf.LED, gpio.LOW)
			--gpio.write(conf.BUZZER, gpio.LOW)
			conf.OFFON = 0
			ok, stoped = pcall(cjson.encode, {M="say",ID=r.ID,C="Stop monitoring"})
			cu:send( stoped.."\n" )
		end
		if r.C == "offOn" then
			--gpio.write(conf.LED, gpio.LOW)
			gpio.write(conf.BUZZER, gpio.LOW)
			ok, stoped = pcall(cjson.encode, {M="say",ID=r.ID,C="Stop alarming"})
			cu:send( stoped.."\n" )
		end
	end
	if r.M == "login" then
		local v = {[conf.INPUTID] = conf.STATUS}
		ok6, s6 = pcall(cjson.encode, {M="update",ID=conf.DEVICEID,V=v})
		if ok6 then
		  print(s6)
		  tmr.delay(500)
		  cu:send( s6.."\n" )
		else
		  print("failed to encode 6 !")
		end
	end
end)
--receive end