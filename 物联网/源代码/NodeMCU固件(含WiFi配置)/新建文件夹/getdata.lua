local bitStream = {}
pin_dht=0
bitStream = {}
for j = 1, 40, 1 do
bitStream[j] = 0
end
bitlength = 0
--发送开始信号
gpio.mode(pin_dht, gpio.OUTPUT)
gpio.write(pin_dht, gpio.LOW)
tmr.delay(20000)；
gpio.write(pin_dht, gpio.HIGH)
--Use Markus Gritsch trick to speed up read/write on GPIO
gpio_read = gpio.read
gpio_write = gpio.write
gpio.mode(pin_dht, gpio.INPUT)
while (gpio_read(pin_dht) == 0) do end --跳过DHT的低电平响应信号
while (gpio_read(pin_dht) == 1) do end --跳过DHT的高电平信号
for j = 1, 40, 1 do
while (gpio_read(pin_dht) == 0) do end --跳过bit开始的低电平
while (gpio_read(pin_dht) == 1 and bitlength<10) do
bitlength = bitlength + 1 --测试高电平脉冲宽度
end
bitStream[j] = bitlength
bitlength = 0
end
hum = 0;
hum2 = 0;
temp = 0;
temp2 = 0;
ckeckval=0;
----hum1
for i = 1, 8, 1 do
if (bitStream[i + 0]>2) then --脉冲宽度大于2个单位则表示为bit，否则为bit0
hum = hum + 2 ^ (8 - i)
end
end
----hum2
for i = 1, 8, 1 do
if (bitStream[i + 8]>2) then --脉冲宽度大于2个单位则表示为bit，否则为bit0
hum2 = hum2 + 2 ^ (8 - i)
end
end
----temp1
for i = 1, 8, 1 do
if (bitStream[i + 16] >2) then --脉冲宽度大于2个单位则表示为bit，否则为bit0
temp = temp + 2 ^ (8 - i)
end
end
----temp2
for i = 1, 8, 1 do
if (bitStream[i + 24] >2) then --脉冲宽度大于2个单位则表示为bit，否则为bit0
temp2 = temp2 + 2 ^ (8 - i)
end
end
----ckeckval
for i = 1, 8, 1 do
if (bitStream[i + 32] >2) then --脉冲宽度大于2个单位则表示为bit，否则为bit0
ckeckval = ckeckval + 2 ^ (8 - i)
end
end

print("shidu:"..hum.."."..hum2)
print('wendu:'..temp.."."..temp2)
print('ckeckval:'..ckeckval)
gpio_read = nil
gpio_write = nil