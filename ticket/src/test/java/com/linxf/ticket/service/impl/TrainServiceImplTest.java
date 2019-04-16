package com.linxf.ticket.service.impl;

import com.linxf.ticket.TrainApplicationTests;
import com.linxf.ticket.dataobject.Train;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class TrainServiceImplTest extends TrainApplicationTests {

    @Autowired
    private TrainServiceImpl trainService;

    @Test
    public void addTrain() {
        Train train = new Train();
        train.setTid("D2206");
        train.setTrainType("D-动车");
        train.setSeatType1("商务座");
        train.setLastTicket1(100);
        train.setMoney1(43.8);
        train.setSeatType2("一等座");
        train.setLastTicket2(80);
        train.setMoney2(25.6);
        train.setSeatType3("二等座");
        train.setLastTicket3(300);
        train.setMoney3(12.5);
        train.setDriveTime("2");
        train.setStationSum(3);
        train.setSaleSum(0);
        train.setDel(0);
        trainService.addTrain(train);
    }
}