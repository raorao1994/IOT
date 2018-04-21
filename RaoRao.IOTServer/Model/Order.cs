using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;

namespace Model
{
    /// <summary>
    /// 指令信息
    /// </summary>
    public class Order
    {
        /// <summary>
        /// 发送给谁
        /// </summary>
        public EndPoint ToAddress { get; set; }
        /// <summary>
        /// 谁发送的
        /// </summary>
        public EndPoint FromAddress { get; set; }
        /// <summary>
        /// 指令
        /// </summary>
        public string Msg { get; set; }
        /// <summary>
        /// 执行ID
        /// </summary>
        public string ExeID { get; set; }
    }
}
