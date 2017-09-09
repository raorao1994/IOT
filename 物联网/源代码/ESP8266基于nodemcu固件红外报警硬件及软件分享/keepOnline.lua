--keep online
ok1, s1 = pcall(cjson.encode, {M="checkin",ID=conf.DEVICEID,K=conf.APIKEY})
if ok1 then
	tmr.alarm(1, 4000, tmr.ALARM_AUTO, function()
	print("local:"..s1)
		cu:send( s1.."\n" )
	  end)
else
	print("failed to encode1!")
end
tmr.alarm(2, 1800000, tmr.ALARM_AUTO, function()
	node.restart()
	  end)
--keep online end