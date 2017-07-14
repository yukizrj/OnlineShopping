package com.rjt.dao;

import java.util.List;

import com.rjt.entity.Order;
import com.rjt.model.*;

public interface OrderDAO {

    public void saveOrder(CartInfo cartInfo);

    public PaginationResult<OrderInfo> listOrderInfo(int page, int maxResult, int maxNavigationPage);

    public OrderInfo getOrderInfo(String orderId);

    public List<OrderDetailInfo> listOrderDetailInfos(String orderId);

    public void updateCustomerInfo(OrderInfo orderInfo);

    public Order findOrder(String orderId);

    public void delete (String orderId);
}