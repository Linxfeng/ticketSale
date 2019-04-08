package com.linxf.user.repository;

import com.linxf.user.UserApplicationTests;
import com.linxf.user.dataobject.Passenger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class PassengerRepositoryTest extends UserApplicationTests {

    @Autowired
    private PassengerRepository passengerRepository;

    @Test
    public void listPassenger() {
        String uid = "1554086717367104";
        List<Passenger> passengerList = passengerRepository.findByUidAndDel(uid, 0);
        if (passengerList == null || passengerList.size() == 0)
            System.out.println("null");
        for (Passenger passenger : passengerList) {
            System.out.println(passenger);
        }
    }

}