package com.linxf.user.controller;

import com.linxf.common.utils.MD5Util;
import com.linxf.common.utils.RedisCacheUtil;
import com.linxf.common.utils.UUIDUtil;
import com.linxf.common.vo.ResponseVo;
import com.linxf.user.dataobject.UserInfo;
import com.linxf.user.enums.UserTypeEnum;
import com.linxf.user.service.UserInfoService;
import com.linxf.user.utils.VerifyParamsUtil;
import com.linxf.user.vo.UserVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
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
     *
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
            String pwd = userVo.getPassword();
            userVo.setPassword(MD5Util.md5(pwd));//密码MD5加密
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
     *
     * @param userVo
     * @return
     */
    @PostMapping("/login")
    public ResponseVo login(UserVo userVo, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            VerifyParamsUtil.validUserVo(userVo); //校验参数
            String pwd = userVo.getPassword();
            userVo.setPassword(MD5Util.md5(pwd));//密码MD5加密
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

    /**
     * 获取用户信息
     *
     * @return
     */
    @GetMapping("/getUserInfo")
    public ResponseVo getUserInfo(HttpServletRequest request, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            String uid = request.getHeader("uid");
            if (StringUtils.isBlank(uid)) return ResponseVo.notLoginFailed(null);
            UserInfo userInfo = userInfoService.findById(uid);
            return ResponseVo.success("查询用户信息成功！", userInfo);
        } catch (Exception e) {
            log.error("UserController.getUserInfo ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }

    /**
     * 校验用户是否登陆，鉴权
     *
     * @return
     */
    @GetMapping("/check")
    public ResponseVo checkPermission(HttpServletRequest request, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        String uid = request.getHeader("uid");
        if (StringUtils.isBlank(uid)) return ResponseVo.notLoginFailed(null);
        String u_token = request.getHeader("u_token");
        String token = redisCacheUtil.getValue(uid);
        if (StringUtils.equals(token, u_token))
            return ResponseVo.success(null);
        return ResponseVo.failed("登陆失效，请重新登录");
    }

    /**
     * 修改用户个人信息
     *
     * @param userVo
     * @return
     */
    @PostMapping("/updateInfo")
    public ResponseVo updateUserInfo(UserVo userVo, HttpServletRequest request, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            String uid = request.getHeader("uid");
            if (StringUtils.isBlank(uid)) return ResponseVo.notLoginFailed(null);

            //先根据用户填的电话号码查询
            UserInfo userInfo = userInfoService.findByPhone(userVo.getPhone());

            //如果号码是自己的，且号码没更新，则更新其他信息：用户名，地址
            if (userInfo != null && StringUtils.equals(userInfo.getUid(), uid)) {
                if (StringUtils.isNotBlank(userVo.getUsername()))
                    userInfo.setUsername(userVo.getUsername());
                if (StringUtils.isNotBlank(userVo.getAddress()))
                    userInfo.setAddress(userVo.getAddress());

            } else if (userInfo == null) { //根据号码没查到，则根据uid查，并更新信息
                userInfo = userInfoService.findById(uid);
                if (userInfo == null) return ResponseVo.notLoginFailed(null);
                if (StringUtils.isNotBlank(userVo.getUsername()))
                    userInfo.setUsername(userVo.getUsername());
                if (StringUtils.isNotBlank(userVo.getAddress()))
                    userInfo.setAddress(userVo.getAddress());
                if (StringUtils.isNotBlank(userVo.getPhone()))
                    userInfo.setPhone(userVo.getPhone());

            } else {//如果查到号码已存在，且不是自己的
                return ResponseVo.failed("修改失败！该手机号码已被其他用户注册");
            }
            //更新用户信息
            userInfoService.updateUserInfo(userInfo);
            return ResponseVo.success("修改成功");
        } catch (Exception e) {
            log.error("UserController.updateUserInfo ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
    }


}
