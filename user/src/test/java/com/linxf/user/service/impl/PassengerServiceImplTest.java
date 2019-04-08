package com.linxf.user.service.impl;

import com.linxf.common.utils.UUIDUtil;
import com.linxf.user.UserApplicationTests;
import com.linxf.user.dataobject.Passenger;
import com.linxf.user.enums.PassengerTypeEnum;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class PassengerServiceImplTest extends UserApplicationTests {

    @Autowired
    private PassengerServiceImpl passengerService;

    @Test
    public void findPassenger() {
        Passenger passenger = new Passenger();
        passenger.setUid("1554086717367104");
        passenger.setTrueName("测试");
        passenger.setIdCard("123456789012345678");
        passenger.setRole(PassengerTypeEnum.ADULT.getCode());
        Passenger p = passengerService.findPassenger(passenger);
        System.out.println(p);
    }

    @Test
    public void createUser() {
        Passenger passenger = new Passenger();
        passenger.setUid("1554086717367104");
        passenger.setPid(UUIDUtil.get16UUID());
        passenger.setTrueName("测试");
        passenger.setIdCard("123456789012345678");
        passenger.setRole(PassengerTypeEnum.ADULT.getCode());
        passengerService.createPassenger(passenger);
    }

    @Test
    public void deletePassenger() {
        String pid = "1554645635284698";
        passengerService.deletePassenger(pid);
    }
}