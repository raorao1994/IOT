---设置温度传感数据对象
local bitStream = {};
---设置DHT11传感器GPIO口
pin_dht=0;
---先将数据置为0
for j = 1, 40, 1 do
	bitStream[j] = 0;
end
bitlength = 0
--发送开始信号
gpio.mode(pin_dht, gpio.OUTPUT);
---先拉低电平至少18ms
gpio.write(pin_dht, gpio.LOW);
tmr.delay(20000);
---定义GPIO读取和写入方法
gpio_read = gpio.read;
gpio_write = gpio.write;
---将GPIO口定义为读取状态
gpio.mode(pin_dht, gpio.INPUT);
while (gpio_read(pin_dht) == 0) do end --跳过DHT的低电平响应信号
while (gpio_read(pin_dht) == 1) do end --跳过DHT的高电平信号
---读取数据
for j = 1, 40, 1 do
	while (gpio_read(pin_dht) == 0) do end --跳过bit开始的低电平
	while (gpio_read(pin_dht) == 1 and bitlength<10) do
		bitlength = bitlength + 1; --测试高电平脉冲宽度
	end
	bitStream[j] = bitlength;
	bitlength = 0;
end
hum = 0;---湿度数据
temp = 0;---温度数据
---解析数据
for i = 1, 8, 1 do
	if (bitStream[i + 0]>2) then --脉冲宽度大于30个单位则表示为bit，否则为bit0
		hum = hum + 2 ^ (8 - i)
	end
end
for i = 1, 8, 1 do
	if (bitStream[i + 16] >2) then --脉冲宽度大于30个单位则表示为bit，否则为bit0
		temp = temp + 2 ^ (8 - i)
	end
end
print("shidu:"..hum);
print('wendu:'..temp);
gpio_read = nil
gpio_write = nil

