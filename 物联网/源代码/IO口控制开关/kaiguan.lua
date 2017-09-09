DEVICEID = "2795"
APIKEY = "d843dc6d8"
INPUTID1 = "2697"
INPUTID2= "2713"
host = host or "www.bigiot.net"
port = port or 8181
LED = 4
gpio.mode(LED,gpio.OUTPUT)
local function run()
  local cu = net.createConnection(net.TCP)
  cu:on("receive", function(cu, c) 
    print(c)
    r = cjson.decode(c)
    if r.M == "say" then
      if r.C == "play" then   
        gpio.write(LED, gpio.HIGH)  
        ok, played = pcall(cjson.encode, {M="say",ID=r.ID,C="led open!"})
        cu:send( played.."\n" )
      end
      if r.C == "stop" then   
        gpio.write(LED, gpio.LOW)
        ok, stoped = pcall(cjson.encode, {M="say",ID=r.ID,C="led close!"})
        cu:send( stoped.."\n" ) 
      end
    end
  end)
  cu:on('disconnection',function(scu)
    cu = nil
    --停止心跳包发送定时器，5秒后重试
    tmr.stop(1)
    tmr.alarm(6, 5000, 0, run)
  end)
  cu:connect(port, host)
  ok, s = pcall(cjson.encode, {M="checkin",ID=DEVICEID,K=APIKEY})
  if ok then
    print(s)
  else
    print("failed to encode!")
  end
  cu:send(s.."\n")
  tmr.alarm(1, 5000, 1, function()
    cu:send(s.."\n")
    dofile("getdata.lua")
    local vvv = {[INPUTID1]=temp,[INPUTID2]=hum};
    ok2 ,s2= pcall(cjson.encode,{M="update",ID=DEVICEID ,V=vvv});
    if ok2  then
    	print(s2)
     	cu:send(s2.."\n")
  	else
    	print("failed to encode!")
  	end
  end)
end
run()