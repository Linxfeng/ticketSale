package com.linxf.ticket.service.impl;

import com.linxf.common.utils.UUIDUtil;
import com.linxf.ticket.TrainApplicationTests;
import com.linxf.ticket.dataobject.Station;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

public class StationServiceImplTest extends TrainApplicationTests {

    @Autowired
    private StationServiceImpl stationService;

    @Test
    public void addStation() {
        Station station = new Station();
        station.setId(UUIDUtil.get16UUID());
        station.setTid("D2206");
        station.setName1("杭州");
        station.setTime1(Time.valueOf("11:12:00"));
        station.setName2("上海");
        station.setTime2(Time.valueOf("14:15:00"));
        station.setIsNextDay(0);
        station.setTicket(86);
        station.setMoney(26.8);
        stationService.addStation(station);
    }

    @Test
    public void addStationList() {
        List<Station> stationList = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            Station station = new Station();
//            if (i==5) station=null;//这行是测试事务一致性
            station.setId(UUIDUtil.get16UUID());
            station.setTid("D2206");
            station.setName1("杭州");
            station.setTime1(Time.valueOf("11:12:00"));
            station.setName2("上海");
            station.setTime2(Time.valueOf("14:15:00"));
            station.setIsNextDay(0);
            station.setTicket(86);
            station.setMoney(26.8);
            stationList.add(station);
        }
        stationService.addStationList(stationList);
    }
}