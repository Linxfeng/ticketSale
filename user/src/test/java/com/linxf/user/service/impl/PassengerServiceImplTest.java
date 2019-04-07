package com.linxf.user.service.impl;

import com.linxf.user.UserApplicationTests;
import com.linxf.user.dataobject.Passenger;
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
        passenger.setRole(0);
        Passenger p = passengerService.findPassenger(passenger);
        System.out.println(p);
    }
}