package com.linxf.ticket.vo;

import com.linxf.ticket.dataobject.Station;
import lombok.Data;

import java.util.List;

/**
 * 列车页面VO对象
 *
 * @author lintao
 * @date 2019/4/15
 */
@Data
public class TrainVo {

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

    private List<Station> stationList;// 车站列表

}
