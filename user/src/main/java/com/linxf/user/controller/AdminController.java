package com.linxf.user.controller;

import com.linxf.common.utils.MD5Util;
import com.linxf.common.utils.RedisCacheUtil;
import com.linxf.common.vo.ResponseVo;
import com.linxf.user.dataobject.UserInfo;
import com.linxf.user.enums.UserTypeEnum;
import com.linxf.user.service.UserInfoService;
import com.linxf.user.utils.ConvertUtil;
import com.linxf.user.vo.UserVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

/**
 * @Author lintao
 * @Date 2019/3/30
 */
@Slf4j
@RestController
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserInfoService userInfoService;

    @Autowired
    private RedisCacheUtil redisCacheUtil;

    /**
     * 用户登陆
     * @param userVo
     * @return
     */
    @PostMapping("/login")
    public ResponseVo login(UserVo userVo, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            Assert.notNull(userVo, "参数不能为空！");
            Assert.notNull(userVo.getUsername(), "用户名不能为空！");
            Assert.notNull(userVo.getPassword(), "密码不能为空！");
            String pwd = userVo.getPassword();
            userVo.setPassword(MD5Util.md5(pwd));//密码MD5加密
            UserInfo user = new ConvertUtil().convertUser(userVo, UserTypeEnum.ADMIN.getCode());
            UserInfo userInfo = userInfoService.findByUser(user);
            if (userInfo == null)
                return ResponseVo.failed("登陆失败！用户名密码错误，请重试");
            String token = redisCacheUtil.setAndReturnUUID(userInfo.getUid());//用户信息写入redis
            response.addHeader("uid", userInfo.getUid());//用户信息uid写入浏览器响应头
            response.addHeader("u_token", token);//认证信息token写入浏览器响应头
        } catch (Exception e) {
            log.error("【管理员登陆】失败, {}", userVo);
            log.error("AdminController.login ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
        return ResponseVo.success("登陆成功！");
    }

}
