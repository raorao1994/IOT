wifi.setmode(wifi.STATION)  
wifi.sta.config("CM","caimeng123")  
print(wifi.sta.getip())  
led0 = 0  
led1 = 1
led2 = 2  
led3 = 3  
led4 = 4  
led5 = 5  
led6 = 6  
led7 = 7  
led8 = 8  
gpio.mode(led0, gpio.OUTPUT)  
gpio.mode(led1, gpio.OUTPUT)  
gpio.mode(led2, gpio.OUTPUT)  
gpio.mode(led3, gpio.OUTPUT) 
gpio.mode(led4, gpio.OUTPUT)  
gpio.mode(led5, gpio.OUTPUT) 
gpio.mode(led6, gpio.OUTPUT)  
gpio.mode(led7, gpio.OUTPUT) 
gpio.mode(led8, gpio.OUTPUT)  
srv=net.createServer(net.TCP)  
srv:listen(80,function(conn)  
    conn:on("receive", function(client,request)  
        local buf = "";  
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");  
        if(method == nil)then  
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");  
        end  
        local _GET = {}  
        if (vars ~= nil)then  
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do  
                _GET[k] = v  
            end  
        end  
        buf = buf.."<h1> ESP8266 Web Server</h1>";  
        buf = buf.."<p>GPIO0 <a href=\"?pin=ON0\"><button>ON</button></a> <a href=\"?pin=OFF0\"><button>OFF</button></a></p>";  
        buf = buf.."<p>GPIO1 <a href=\"?pin=ON1\"><button>ON</button></a> <a href=\"?pin=OFF1\"><button>OFF</button></a></p>";  
        buf = buf.."<p>GPIO2 <a href=\"?pin=ON2\"><button>ON</button></a> <a href=\"?pin=OFF2\"><button>OFF</button></a></p>";  
        buf = buf.."<p>GPIO3 <a href=\"?pin=ON3\"><button>ON</button></a> <a href=\"?pin=OFF3\"><button>OFF</button></a></p>";
        buf = buf.."<p>GPIO4 <a href=\"?pin=ON4\"><button>ON</button></a> <a href=\"?pin=OFF4\"><button>OFF</button></a></p>";  
        buf = buf.."<p>GPIO5 <a href=\"?pin=ON5\"><button>ON</button></a> <a href=\"?pin=OFF5\"><button>OFF</button></a></p>";
        buf = buf.."<p>GPIO6 <a href=\"?pin=ON6\"><button>ON</button></a> <a href=\"?pin=OFF6\"><button>OFF</button></a></p>";  
        buf = buf.."<p>GPIO7 <a href=\"?pin=ON7\"><button>ON</button></a> <a href=\"?pin=OFF7\"><button>OFF</button></a></p>";
        buf = buf.."<p>GPIO8 <a href=\"?pin=ON8\"><button>ON</button></a> <a href=\"?pin=OFF8\"><button>OFF</button></a></p>";
        local _on,_off = "",""  
        if(_GET.pin == "ON0")then  
              gpio.write(led0, gpio.HIGH);  
        elseif(_GET.pin == "OFF0")then  
              gpio.write(led0, gpio.LOW);  
        elseif(_GET.pin == "ON1")then  
              gpio.write(led1, gpio.HIGH);  
        elseif(_GET.pin == "OFF1")then  
              gpio.write(led1, gpio.LOW);  
        elseif(_GET.pin == "ON2")then  
              gpio.write(led2, gpio.HIGH);  
        elseif(_GET.pin == "OFF2")then  
              gpio.write(led2, gpio.LOW); 
        elseif(_GET.pin == "ON3")then  
              gpio.write(led3, gpio.HIGH);  
        elseif(_GET.pin == "OFF3")then  
              gpio.write(led3, gpio.LOW);
        elseif(_GET.pin == "ON4")then  
              gpio.write(led4, gpio.HIGH);  
        elseif(_GET.pin == "OFF4")then  
              gpio.write(led4, gpio.LOW); 
        elseif(_GET.pin == "ON5")then  
              gpio.write(led5, gpio.HIGH);  
        elseif(_GET.pin == "OFF5")then  
              gpio.write(led5, gpio.LOW); 
        elseif(_GET.pin == "ON6")then  
              gpio.write(led6, gpio.HIGH);  
        elseif(_GET.pin == "OFF6")then  
              gpio.write(led6, gpio.LOW); 
        elseif(_GET.pin == "ON7")then  
              gpio.write(led7, gpio.HIGH);  
        elseif(_GET.pin == "OFF7")then  
              gpio.write(led7, gpio.LOW); 
        elseif(_GET.pin == "ON8")then  
              gpio.write(led8, gpio.HIGH);  
        elseif(_GET.pin == "OFF8")then  
              gpio.write(led8, gpio.LOW);       
        end  
        client:send(buf);  
        client:close();  
        collectgarbage();  
    end)  
end)  