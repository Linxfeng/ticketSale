package com.linxf.user.service.impl;

import com.linxf.common.utils.MD5Util;
import com.linxf.common.utils.UUIDUtil;
import com.linxf.user.UserApplicationTests;
import com.linxf.user.dataobject.UserInfo;
import com.linxf.user.enums.UserTypeEnum;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class UserInfoServiceImplTest extends UserApplicationTests {

    @Autowired
    private UserInfoServiceImpl userInfoServiceImpl;

    @Test
    public void createUser() {
        UserInfo userInfo = new UserInfo();
        userInfo.setUid(UUIDUtil.get16UUID());
        userInfo.setUsername("测试");
        userInfo.setPassword(MD5Util.md5("123456"));
        userInfo.setPhone("13312341234");
        userInfo.setAddress("浙江省杭州市");
        userInfo.setUserType(UserTypeEnum.ORDINARY.getCode());
        userInfoServiceImpl.createUser(userInfo);
    }

}