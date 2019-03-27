package com.linxf.user.controller;

import com.linxf.common.utils.UUIDUtil;
import com.linxf.common.vo.ResponseVo;
import com.linxf.user.dataobject.UserInfo;
import com.linxf.user.enums.UserTypeEnum;
import com.linxf.user.service.UserInfoService;
import com.linxf.user.utils.VerifyParamsUtil;
import com.linxf.user.vo.UserVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

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

    /**
     * 用户注册
     * @param userVo
     * @return
     */
    @PostMapping("/register")
    public ResponseVo register(UserVo userVo) {
        UserInfo userInfo = new UserInfo();
        try {
            VerifyParamsUtil.validUserVo(userVo); //校验参数
            UserInfo user = userInfoService.findByPhone(userVo.getPhone());
            if (user != null)
                return ResponseVo.failed("注册失败！该号码已被注册，用户名："+user.getUsername());
            BeanUtils.copyProperties(userVo, userInfo);
            userInfo.setUid(UUIDUtil.get16UUID());
            userInfo.setUserType(UserTypeEnum.ORDINARY.getCode());
            userInfoService.createUser(userInfo);
        } catch (Exception e) {
            log.error("【用户注册】失败, {}", userVo);
            log.error("UserController.register ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("uid", userInfo.getUid());
        return ResponseVo.success("注册成功！", resultMap);
    }

}
