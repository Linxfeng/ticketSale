package com.linxf.user.service.impl;

import com.linxf.user.dataobject.Passenger;
import com.linxf.user.repository.PassengerRepository;
import com.linxf.user.service.PassengerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * 乘客服务实现类
 *
 * @Author lintao
 * @Date 2019/4/7
 */
@Service
public class PassengerServiceImpl implements PassengerService {

    @Autowired
    private PassengerRepository passengerRepository;

    /**
     * 根据乘客信息查询
     *
     * @param passenger
     * @return
     */
    @Override
    public Passenger findPassenger(Passenger passenger) {
        Example<Passenger> example = Example.of(passenger);
        Optional<Passenger> optional = passengerRepository.findOne(example);
        if (!optional.isPresent()) return null;
        return optional.get();
    }

    /**
     * 新增乘客
     *
     * @param passenger
     */
    @Override
    public void createPassenger(Passenger passenger) {
        passengerRepository.save(passenger);
    }

    /**
     * 查询用户下[有效]乘客列表
     *
     * @param uid 用户id
     * @return
     */
    @Override
    public List<Passenger> listPassenger(String uid) {
        return passengerRepository.findByUidAndDel(uid, 0);
    }


}
