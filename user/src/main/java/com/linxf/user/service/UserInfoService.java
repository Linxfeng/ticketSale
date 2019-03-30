package com.linxf.user.service;

import com.linxf.user.dataobject.UserInfo;

/**
 * 用户信息服务
 *
 * @author lintao
 * @date 2019/3/27
 */
public interface UserInfoService {

    /**
     * 创建用户
     * @param userInfo
     * @return
     */
    UserInfo createUser(UserInfo userInfo);

    /**
     * 根据电话号码查找用户--号码唯一
     * @param phone
     * @return
     */
    UserInfo findByPhone(String phone);

    /**
     * 根据User各参数查找用户
     * @param userInfo
     * @return
     */
    UserInfo findByUser(UserInfo userInfo);

}
