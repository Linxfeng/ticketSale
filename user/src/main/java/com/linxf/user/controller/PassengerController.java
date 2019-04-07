package com.linxf.user.controller;

import com.linxf.common.vo.ResponseVo;
import com.linxf.user.dataobject.Passenger;
import com.linxf.user.utils.VerifyParamsUtil;
import com.linxf.user.vo.PassengerVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 乘客Controller
 *
 * @Author lintao
 * @Date 2019/4/7
 */
@Slf4j
@RestController
@RequestMapping("/passenger")
public class PassengerController {

    /**
     * 新增乘客
     *
     * @param passengerVo
     * @return
     */
    @PostMapping("/create")
    public ResponseVo createPassenger(PassengerVo passengerVo,
                                      HttpServletRequest request, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            String uid = request.getHeader("uid");
            if (StringUtils.isBlank(uid)) return ResponseVo.notLoginFailed(null);

            VerifyParamsUtil.validPassengerVo(passengerVo); //校验参数
            Passenger passenger = new Passenger();
            BeanUtils.copyProperties(passengerVo, passenger);
            passenger.setUid(uid);
            //先根据乘客信息查询

            //新增乘客

        } catch (Exception e) {
            log.error("【新增乘客】失败, {}", passengerVo);
            log.error("PassengerController.createPassenger ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
        return ResponseVo.success("操作成功！");
    }

}
