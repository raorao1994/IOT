using Model;
using RaoRao.Socket.TCPHelper;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Text;
using System.Windows.Forms;
using Newtonsoft.Json;

namespace RaoRao.IOTServer
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string port = textBox_port.Text;
            int _port;
            if (!int.TryParse(port, out _port))
            {
                MessageBox.Show("端口号输入错误，请重新输入");
            }
            else
            {
                Program.engine = new TCPEngine(_port);
                Program.engine.CreateServer(50);
                Program.engine.MessageReceived += ReceivedMsg;
                Program.engine.ClientDisconnected += leave;
                Program.engine.ClientConnected += online;
                textBox1.Text += "服务器启动成功" + " \r\n";
            }
        }
        /// <summary>
        /// 接收到信息
        /// </summary>
        /// <param name="address"></param>
        /// <param name="msg"></param>
        private void ReceivedMsg(EndPoint address,string msg)
        {
            
            textBox1.Text += "客户端:"+address+"信息:"+ msg+ " \r\n";
            try
            {
                MessageModel model = JsonConvert.DeserializeObject<MessageModel>(msg);
                //物联网设备上传数据
                if (model.MsgType == (int)MsgType.UPDATA && model.UserType == (int)UserType.CLIENT)
                {
                    updata(address, model);
                    return;
                }
                //物联网设备上传设备模块列表数据
                if (model.MsgType == (int)MsgType.UPDATAEXEIDLIST && model.UserType == (int)UserType.CLIENT)
                {
                    updata(address, model);
                    return;
                }
                //用户设备发送指令
                if (model.MsgType == (int)MsgType.SENT && model.UserType == (int)UserType.SERVER)
                {
                    sentmsg(address, model);
                    return;
                }
                //用户设备获取数据
                if (model.MsgType == (int)MsgType.GET && model.UserType == (int)UserType.SERVER)
                {
                    getdata(address, model);
                    return;
                }
            }
            catch (Exception e) {
                textBox1.Text += "客户端:" + address + "上传数据格式有误 \r\n";
            }
        }
        /// <summary>
        /// 上线
        /// </summary>
        private void online(EndPoint address)
        {
            textBox1.Text += "客户端:" + address + "上线:" + " \r\n";
        }
        /// <summary>
        /// 离线
        /// </summary>
        /// <param name="address"></param>
        private void leave(IPEndPoint address)
        {
            textBox1.Text += "客户端:" + address + "下线:" + " \r\n";
        }

        /// <summary>
        /// 上传数据存储
        /// </summary>
        /// <param name="address"></param>
        /// <param name="msg"></param>
        private void updata(EndPoint address, MessageModel msg)
        {

        }
        /// <summary>
        /// 发送指令
        /// </summary>
        /// <param name="address"></param>
        /// <param name="msg"></param>
        private void sentmsg(EndPoint address, MessageModel msg)
        {
            try
            {
                Order model = JsonConvert.DeserializeObject<Order>(msg.Data);
                Program.engine.SendMsg((IPEndPoint)model.ToAddress, msg.Data);
            }
            catch (Exception e)
            {
                textBox1.Text += "发送指令失败，详细信息请查看日志 \r\n";
                Log.LogOperater.Error(this, "发送指令失败");
            }
        }
        /// <summary>
        /// 获取获取
        /// </summary>
        /// <param name="address"></param>
        /// <param name="msg"></param>
        private void getdata(EndPoint address, MessageModel msg)
        {

        }
    }
}
