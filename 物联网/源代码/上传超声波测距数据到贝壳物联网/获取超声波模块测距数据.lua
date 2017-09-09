---设置输入端和输出端IO口
---GPIO_trig为输入端GPIO_echo为输出端
GPIO_echo=0;
GPIO_trig=1;
---首先向输入端至少10us的高电平脉冲GPIO_trig
gpio.mode(GPIO_trig, gpio.OUTPUT);
gpio.mode(GPIO_echo, gpio.INPUT);
---添加GPIO读取函数，方便调用
gpio_read = gpio.read;
---发送开始信号
gpio.write(GPIO_trig, gpio.HIGH);
tmr.delay(20);---tmr.delay();单位是us
---置低电平，等待信息输出
gpio.write(GPIO_trig, gpio.LOW);
Distance=0;
while (gpio_read(GPIO_echo) == 0) do end --跳过ECHO的低电平响应信号
local s = tmr.now();
while (gpio_read(GPIO_echo) == 1) do end --计算Echo的高电平信号时间
local e = tmr.now();
local time=e-s;
Distance=time*0.34/20;
print("CM:"..Distance);