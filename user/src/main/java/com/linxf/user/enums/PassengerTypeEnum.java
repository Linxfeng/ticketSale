package com.linxf.user.enums;

import lombok.Getter;

/**
 * 乘客类型
 *
 * @author lintao
 * @date 2019/4/7
 */
@Getter
public enum PassengerTypeEnum {

    ADULT(0, "成人"),
    STUDENT(1, "学生"),
    ;

    private Integer code;
    private String type;

    PassengerTypeEnum(Integer code, String type) {
        this.code = code;
        this.type = type;
    }

}
