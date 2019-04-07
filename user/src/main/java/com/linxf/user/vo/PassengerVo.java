package com.linxf.user.vo;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

/**
 * 页面乘客vo对象
 * @author lintao
 * @date 2019/4/7
 */
@Data
public class PassengerVo {

    @JsonProperty("id")
    private String pid;//乘客id

    private String trueName;// 真实姓名

    private String idCard;// 身份证号

    private Integer role;// 乘客身份：0代表成人票，1代表学生票

}