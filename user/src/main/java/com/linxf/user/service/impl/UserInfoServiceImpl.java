package com.linxf.user.service.impl;

import com.linxf.user.dataobject.UserInfo;
import com.linxf.user.repository.UserInfoRepository;
import com.linxf.user.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 用户服务实现类
 *
 * @author lintao
 * @date 2019/3/27
 */
@Service
public class UserInfoServiceImpl implements UserInfoService {

    @Autowired
    UserInfoRepository userInfoRepository;

    /**
     * 创建用户
     *
     * @param userInfo
     * @return
     */
    @Override
    public UserInfo createUser(UserInfo userInfo) {
        return userInfoRepository.save(userInfo);
    }

    /**
     * 根据电话号码查找用户--号码唯一
     *
     * @param phone
     * @return
     */
    @Override
    public UserInfo findByPhone(String phone) {
        return userInfoRepository.findByPhone(phone);
    }

}
