package com.linxf.user.dataobject;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * 乘客
 * @author lintao
 * @date 2019/3/26
 */
@Data
@Entity
public class Passenger {

    @Id
    private String pid;// 乘客编号

    private String uid;//用户id

    private String trueName;// 真实姓名

    private String idCard;// 身份证号

    private Integer role;// 乘客身份：0代表成人票，1代表学生票

    private Integer del = 0;// 是否删除：0代表正常状态，1代表已删除

}
