package com.linxf.ticket.repository;

import com.linxf.ticket.TrainApplicationTests;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class StationRepositoryTest extends TrainApplicationTests {

    @Autowired
    private StationRepository stationRepository;

    @Test
    public void findTidByName1() {
        List<String> list = stationRepository.findTidByName1("上海");
        List<String> list2 = stationRepository.findTidByName2("杭州");
        if (list2 != null && list2.size() != 0)
            for (String tid : list2) {
                System.out.println(tid);
            }
        System.out.println("null");
    }

}