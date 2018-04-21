using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model
{
    /// <summary>
    /// 信息类型
    /// </summary>
    public enum MsgType
    {
        /// <summary>
        /// 获取数据
        /// </summary>
        GET = 0,
        /// <summary>
        /// 上传数据
        /// </summary>
        UPDATA = 1,//
        /// <summary>
        /// 发送指令
        /// </summary>
        SENT = 2,//
        /// <summary>
        /// 上传模块列表信息，一个设备可能有多个模块，多个模块ExeID以|分割
        /// </summary>
        UPDATAEXEIDLIST = 3
    };
    /// <summary>
    /// 用户类型
    /// </summary>
    public enum UserType
    {
        /// <summary>
        /// 客户端设备，用户获取数据
        /// </summary>
        SERVER = 0,//
        /// <summary>
        /// IOT物联网设备
        /// </summary>
        CLIENT = 1//
    };
}
