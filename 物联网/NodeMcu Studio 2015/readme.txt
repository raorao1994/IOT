�䶯��¼��
2014.12.26��beta0.3
1.ȥ���˴����ʱ��֤NodeMcu�Ƿ����ߵĹ��ܣ�
2.�������ַ�����ת�幦�ܡ�

NodeMcu Studio 2015.exe ���԰�

1����NodeMcu Studio 2015.exe���ڵ�Ŀ¼����һ����Ϊ"Lua Programs"���ļ��У����Ѿ��༭�õ�.lua�ļ����������ļ����ڡ�
2������NodeMcu Studio 2015.exe������ѡ�񴮿ڵĶԻ�������ȷѡ�񴮿ڡ�
3,����All Programs�£�ѡ����Ҫ���ص�nodemcu���ļ������"Download"��


ChangeLog
2014.12.26��beta0.3
1.cancle the verifying nodemcu firmware function when open this software ��
2.fixed the bug of escape character when download *.lua file using file.writeline().


NodeMcu Studio 2015.exe for windows 7 and xp(.net frame work 4.0 and later version is required)

1, To make sure this Application works smooth, you should install your serial communication hardware correctly and you can find it in Device Manager.
2, Power up your esp8266 module.
3, Run this application, a dialog window pops out to require a seriport name to be used.Choose the serialport you are intend to use. 
4, If you run this application for the first time, a directory named 'Lua Programs' will be created. copy your *.lua file into this directory.
5, quit this application and run it again(remember power up your module before open this application), then you will find lua files in 'All Programs'. list.
6, Click the file name which you want to download into esp8266. The content of this lua file will be displayed in the right-up side window. Then click the 'Download' in tool bar. you should wait and do nothing until right-down side window update with a charactor chunk, end with '> file.close()'.
7, After step 6, you can you click"Excute", then the file you just download into esp8266 is exuted by 'dofile('yourfile.lua').


8, for an simple example, you can create a file named 'foo.lua' in the 'Lua Programs' dir, then edit it with only 'print("hello,this is nodemcu")', save and close it.
9, Run this application(remember power-up), choose com port, then click foo.lua, and click 'Download', wait for response, after that click 'Excute'. then you will find "hello nodemcu" displays in right down window. 

  Now write your lua code and run it in nodemcu firmware. Good luck! any questions please visit https://github.com/nodemcu/nodemcu-firmware     