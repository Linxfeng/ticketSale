package com.linxf.user.controller;

import com.linxf.common.utils.UUIDUtil;
import com.linxf.common.vo.ResponseVo;
import com.linxf.user.dataobject.UserInfo;
import com.linxf.user.enums.UserTypeEnum;
import com.linxf.user.service.UserInfoService;
import com.linxf.user.utils.RedisCacheUtil;
import com.linxf.user.utils.VerifyParamsUtil;
import com.linxf.user.vo.UserVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

/**
 * @author lintao
 * @date 2019/3/27
 */
@Slf4j
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserInfoService userInfoService;

    @Autowired
    private RedisCacheUtil redisCacheUtil;

    /**
     * 用户注册
     * @param userVo
     * @return
     */
    @PostMapping("/register")
    public ResponseVo register(UserVo userVo, HttpServletResponse response) {
        UserInfo userInfo = new UserInfo();
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            VerifyParamsUtil.validUserVo(userVo); //校验参数
            UserInfo user = userInfoService.findByPhone(userVo.getPhone());
            if (user != null)
                return ResponseVo.failed("注册失败！该号码已被注册，用户名："+user.getUsername());
            BeanUtils.copyProperties(userVo, userInfo);
            userInfo.setUid(UUIDUtil.get16UUID());
            userInfo.setUserType(UserTypeEnum.ORDINARY.getCode());
            userInfoService.createUser(userInfo);
            String uid = userInfo.getUid();
            String token = redisCacheUtil.setAndReturnUUID(uid);//用户信息写入redis
            response.addHeader("uid", uid);//用户信息uid写入浏览器响应头
            response.addHeader("u_token", token);//认证信息token写入浏览器响应头
        } catch (Exception e) {
            log.error("【用户注册】失败, {}", userVo);
            log.error("UserController.register ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
        return ResponseVo.success("注册成功！");
    }

    /**
     * 用户登陆
     * @param userVo
     * @return
     */
    @PostMapping("/login")
    public ResponseVo login(UserVo userVo, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            VerifyParamsUtil.validUserVo(userVo); //校验参数
            UserInfo userInfo = userInfoService.findByPhone(userVo.getPhone());
            if (userInfo == null)
                return ResponseVo.failed("登陆失败！号码" + userInfo.getPhone() + "未注册");
            if (!StringUtils.equals(userVo.getUsername(), userInfo.getUsername()))
                return ResponseVo.failed("登陆失败！该号码对应的用户名为：" + userInfo.getUsername());
            if (!StringUtils.equals(userVo.getPassword(), userInfo.getPassword()))
                return ResponseVo.failed("登陆失败！密码错误");
            String token = redisCacheUtil.setAndReturnUUID(userInfo.getUid());//用户信息写入redis
            response.addHeader("uid", userInfo.getUid());//用户信息uid写入浏览器响应头
            response.addHeader("u_token", token);//认证信息token写入浏览器响应头
        } catch (Exception e) {
            log.error("【用户登陆】失败, {}", userVo);
            log.error("UserController.login ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
        return ResponseVo.success("登陆成功！");
    }

}
