package com.linxf.ticket.dataobject;


import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Time;

/**
 * 车站
 *
 * @author lintao
 * @date 2019/4/13
 */
@Data
@Entity
public class Station {

    @Id
    private String id;//id,没啥用

    private String tid;// 车次编号

    private String name1;// 出发站

    private Time time1;// 出站时间 //Time.valueOf("11:12:00")

    private String name2;// 到达站--是name1的下一站

    private Time time2;// 到站时间

    private Integer isNextDay;//是否次日到达：0当天，1次日

    private Integer ticket;// 区段余票

    private Double money;// 区段票价

}
