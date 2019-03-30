package com.linxf.user.utils;

import com.linxf.user.dataobject.UserInfo;
import com.linxf.user.vo.UserVo;
import org.springframework.beans.BeanUtils;

/**
 * 转换工具类
 *
 * @Author lintao
 * @Date 2019/3/30
 */
public class ConvertUtil {

    /**
     * userVo -> userInfo
     * @param userType
     * @return
     */
    public UserInfo convertUser(UserVo userVo, Integer userType){
        UserInfo userInfo = new UserInfo();
        BeanUtils.copyProperties(userVo, userInfo);
        userInfo.setUserType(userType);
        return userInfo;
    }


}
