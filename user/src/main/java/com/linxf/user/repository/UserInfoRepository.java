package com.linxf.user.repository;

import com.linxf.user.dataobject.UserInfo;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 用户Dao层
 *
 * @author lintao
 * @date 2019/3/27
 */
public interface UserInfoRepository extends JpaRepository<UserInfo, String> {

    //根据电话号码查找用户
    UserInfo findByPhone(String phone);
}
