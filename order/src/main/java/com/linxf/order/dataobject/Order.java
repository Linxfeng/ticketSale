package com.linxf.order.dataobject;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

/**
 * 订单
 *
 * @author lintao
 * @date 2019/4/13
 */
@Data
@Entity
public class Order {

    @Id
    private String oid;// 订单id

    private String uid;// 所属用户id

    private String pid;// 乘客id

    private String tid;// 车次编号

    private String startStation;// 出发站

    private Date startTime;// 出发时间

    private String endStation;// 到达站

    private Date endTime;// 到达时间

    private Integer seatType;// 座位类型

    private Double amount; // 订单总价

    private Integer orderStatus; // 订单状态

    private Date createTime;// 创建时间

    private Date updateTime;// 创建时间

    private Integer del = 0;// 是否删除：0正常，1已删除

}
