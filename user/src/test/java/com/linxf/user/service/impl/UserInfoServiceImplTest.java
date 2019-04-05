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
        userInfo.setUsername("123");
        userInfo.setPassword(MD5Util.md5("123456"));
        userInfo.setPhone("13312341231");
        userInfo.setAddress("浙江省杭州市");
        userInfo.setUserType(UserTypeEnum.ORDINARY.getCode());
        userInfoServiceImpl.createUser(userInfo);
    }

    @Test
    public void findUser() {
        UserInfo userInfo = new UserInfo();
        userInfo.setUsername("admin");
        userInfo.setPassword(MD5Util.md5("123456"));
//        userInfo.setPhone("13312341234");
//        userInfo.setAddress("浙江省杭州市");
        userInfo.setUserType(UserTypeEnum.ADMIN.getCode());
        UserInfo user = userInfoServiceImpl.findByUser(userInfo);
        System.out.println(user);
    }

    @Test
    public void findUserById() {
        UserInfo user = userInfoServiceImpl.findById("15540865369668641");
        System.out.println(user);
    }

    @Test
    public void updateUser() {
        //更新信息，先查在set值
        UserInfo user = userInfoServiceImpl.findById("1554086717367104");
        user.setAddress("浙江温州");
        userInfoServiceImpl.updateUserInfo(user);
        System.out.println(user);
    }

}