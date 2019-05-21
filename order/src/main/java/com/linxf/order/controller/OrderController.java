package com.linxf.order.controller;

import com.linxf.common.utils.UUIDUtil;
import com.linxf.common.vo.ResponseVo;
import com.linxf.order.OrderVo;
import com.linxf.order.dataobject.Order;
import com.linxf.order.service.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Date;

/**
 * 订单Controller
 *
 * @author lintao
 * @date 2019/4/11
 */
@Slf4j
@RestController
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 创建订单
     *
     * @param orderVo
     * @return
     */
    @PostMapping("/submitOrder")
    public ResponseVo submitOrder(@Valid OrderVo orderVo, BindingResult bindingResult,
                                  HttpServletRequest request, HttpServletResponse response) {
        response.addHeader("Access-Control-Allow-Origin", "*");//CORS跨域
        try {
            String uid = request.getHeader("uid");
            if (StringUtils.isBlank(uid)) return ResponseVo.notLoginFailed(null);
            //校验参数
            Assert.isTrue(!bindingResult.hasErrors(), bindingResult.getFieldError().getDefaultMessage());
            //封装参数
            Order order = this.conventOrder(orderVo, "", "");


        } catch (Exception e) {
            log.error("【创建订单】失败, {}", orderVo);
            log.error("OrderController.submitOrder ERROR:{}", e.getMessage());
            return ResponseVo.failed(e.getMessage());
        }
        return ResponseVo.success("订单创建成功！");
    }

    /**
     * 转换order对象，封装参数
     *
     * @param orderVo
     * @return
     */
    private Order conventOrder(OrderVo orderVo, String uid, String pid) {
        Order order = new Order();
        order.setOid(UUIDUtil.get32UUID());
        order.setUid(uid);
        order.setPid(pid);
        order.setTid(orderVo.getTid());
        order.setStartStation(orderVo.getStartStation());
        order.setStartTime(orderVo.getStartTime());
        order.setEndStation(orderVo.getEndStation());
        order.setEndTime(orderVo.getStartTime());
        order.setSeatType(0);
        order.setAmount(0.0D);
        order.setOrderStatus(0);
        order.setCreateTime(new Date());
        order.setUpdateTime(new Date());
        order.setDel(0);
        return order;
    }

}
