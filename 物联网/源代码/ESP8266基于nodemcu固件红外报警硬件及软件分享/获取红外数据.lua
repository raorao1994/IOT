---设置输入端和输出端IO口
---GPIO_trig为输入端GPIO_echo为输出端
GPIO_echo=1;
GPIO_led=0;
---首先向输入端至少10us的高电平脉冲GPIO_trig
gpio.mode(GPIO_echo, gpio.INPUT);
gpio.mode(GPIO_led, gpio.OUTPUT);
---添加GPIO读取函数，方便调用
gpio_read = gpio.read;
---直接读取数据当有检测到人体运动，输出1，否则输出0.
person=gpio_read(GPIO_echo);
if(person==1) then 
	gpio.write(GPIO_led, gpio.HIGH);
else
	gpio.write(GPIO_led, gpio.LOW);
end
print("person:"..person);