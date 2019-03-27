package com.linxf.user.repository;

import com.linxf.common.utils.MD5Util;
import com.linxf.common.utils.UUIDUtil;
import com.linxf.user.UserApplicationTests;
import com.linxf.user.dataobject.UserInfo;
import com.linxf.user.enums.UserTypeEnum;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class UserInfoRepositoryTest extends UserApplicationTests {

    @Autowired
    private UserInfoRepository userInfoRepository;

    @Test
    public void register() {
        UserInfo userInfo = new UserInfo();
        userInfo.setUid(UUIDUtil.get16UUID());
        userInfo.setUsername("测试");
        userInfo.setPassword(MD5Util.md5("123456"));
        userInfo.setPhone("13312341234");
        userInfo.setAddress("浙江省杭州市");
        userInfo.setUserType(UserTypeEnum.ORDINARY.getCode());
        userInfoRepository.save(userInfo);
    }

    @Test
    public void findByPhone() {
        String phone = "13312341234";
        UserInfo userInfo = userInfoRepository.findByPhone(phone);
        System.out.println(userInfo);
    }

}