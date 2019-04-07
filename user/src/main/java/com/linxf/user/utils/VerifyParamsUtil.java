package com.linxf.user.utils;

import com.linxf.user.vo.PassengerVo;
import com.linxf.user.vo.UserVo;
import org.springframework.util.Assert;

/**
 * 校验参数工具类
 *
 * @author lintao
 * @date 2019/3/27
 */
public class VerifyParamsUtil {

    /**
     * 校验用户vo表单
     */
    public static void validUserVo(UserVo userVo) {
        Assert.notNull(userVo, "参数不能为空！");
        Assert.notNull(userVo.getUsername(), "用户名不能为空！");
        Assert.notNull(userVo.getPassword(), "密码不能为空！");
        Assert.notNull(userVo.getPhone(), "电话号码不能为空！");
    }

    /**
     * 校验乘客vo表单
     */
    public static void validPassengerVo(PassengerVo passengerVo) {
        Assert.notNull(passengerVo, "参数不能为空！");
        Assert.notNull(passengerVo.getTrueName(), "乘客姓名不能为空！");
        Assert.notNull(passengerVo.getIdCard(), "身份证号不能为空！");
        Assert.notNull(passengerVo.getRole(), "乘客类型不能为空！");
    }

}
