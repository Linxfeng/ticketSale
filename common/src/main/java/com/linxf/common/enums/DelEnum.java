package com.linxf.common.enums;

import lombok.Getter;

/**
 * 删除状态枚举
 *
 * @author lintao
 * @date 2019/4/13
 */
@Getter
public enum DelEnum {

    NORMAL(0, "正常"),
    DELETE(1, "删除"),
    ;

    private Integer code;
    private String type;

    DelEnum(Integer code, String type) {
        this.code = code;
        this.type = type;
    }

}
