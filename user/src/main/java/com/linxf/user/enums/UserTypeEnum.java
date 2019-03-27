package com.linxf.user.enums;

import lombok.Getter;

/**
 * 用户类型
 *
 * @author lintao
 * @date 2019/3/27
 */
@Getter
public enum  UserTypeEnum {

    ORDINARY(0, "普通用户"),
    ADMIN(1, "管理员"),
    ;

    private Integer code;
    private String type;

    UserTypeEnum(Integer code, String type) {
        this.code = code;
        this.type = type;
    }

}
