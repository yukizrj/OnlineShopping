package com.rjt.dao;

import com.rjt.entity.OrderDetail;
import com.rjt.model.OrderInfo;

public interface OrderDetailDAO {
    public OrderDetail findOrderDetail(String orderDetailId);

    public void updateOrderDetails(OrderInfo orderInfo);

    public void deleteOrderDetails(OrderInfo orderInfo);
}
