package com.linxf.user.vo;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

/**
 * 用户页面vo对象
 * @author lintao
 * @date 2019/3/27
 */
@Data
public class UserVo {

    @JsonProperty("id")
    private String uid;//用户id

    @JsonProperty("name")
    private String username;// 用户名

    private String password;// 密码

    @JsonProperty("type")
    private Integer userType;// 用户类型：0代表普通用户，1代表管理员

    private String phone;// 联系电话

    private String address;// 收货地址

}
