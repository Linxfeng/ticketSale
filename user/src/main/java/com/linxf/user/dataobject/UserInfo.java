package com.linxf.user.dataobject;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * 用户
 * @author lintao
 * @date 2019/3/26
 */
@Data
@Entity
public class UserInfo {

    @Id
    private String uid;//用户id

    private String username;// 用户名

    private String password;// 密码

    private Integer userType;// 用户类型：0代表普通用户，1代表管理员

    private String phone;// 联系电话

    private String address;// 收货地址

}
