package com.linxf.ticket.dataobject;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * 列车信息
 *
 * @author lintao
 * @date 2019/4/13
 */
@Data
@Entity
public class Train {

    @Id
    private String tid;// 列车车次编号

    private String trainType;// 车辆类型

    //一般列车都会分3个档次的座位类型
    private String seatType1;// 座位类型1
    private Integer lastTicket1;// 座位余票1
    private Double money1;// 票价涨幅1

    private String seatType2;// 座位类型2
    private Integer lastTicket2;// 座位余票2
    private Double money2;// 票价涨幅2

    private String seatType3;// 座位类型3
    private Integer lastTicket3;// 座位余票3
    private Double money3;// 票价涨幅3

    private String driveTime;// 车程耗时-单位:小时

    private Integer stationSum;// 列车途经总站数

    private Integer saleSum;// 售出总票数

    private Integer del = 0;// 是否有效：0在运营，1已停运
}
