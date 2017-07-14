package com.rjt.dao.impl;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.rjt.dao.OrderDAO;
import com.rjt.dao.OrderDetailDAO;
import com.rjt.entity.Order;
import com.rjt.entity.OrderDetail;
import com.rjt.model.OrderDetailInfo;
import com.rjt.model.OrderInfo;

import java.util.List;

//Transactional for Hibernate
@Transactional
public class OrderDetailDAOImpl implements OrderDetailDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Autowired
    private OrderDAO orderDAO;

    @Override
    public OrderDetail findOrderDetail(String orderDetailId) {
        Session session = sessionFactory.getCurrentSession();
        Criteria crit = session.createCriteria(OrderDetail.class);
        crit.add(Restrictions.eq("id", orderDetailId));
        return (OrderDetail) crit.uniqueResult();
    }

    @Override
    public void updateOrderDetails(OrderInfo orderInfo) {
        Session session = sessionFactory.getCurrentSession();

        List<OrderDetailInfo> orderDetails = orderInfo.getDetails();
        if (orderDetails != null) {
            double amount = 0;
            for (OrderDetailInfo orderDetailInfo : orderDetails) {
                OrderDetail orderDetail = this.findOrderDetail(orderDetailInfo.getId());
                if (orderDetail != null) {

                    int newQuantity = orderDetailInfo.getQuantity();
                    int oldQuantity = orderDetail.getQuantity();
                    double price = orderDetail.getPrice();

                    amount += newQuantity * price;

                    if (newQuantity != oldQuantity) {
                        orderDetail.setQuantity(newQuantity);
                        orderDetail.setAmount(price * newQuantity);
                        session.update(orderDetail);
                    }

                }
            }

            //set order total amout
            Order order = this.orderDAO.findOrder(orderInfo.getId());
            if (order != null) {
                order.setAmount(amount);
                session.update(order);
            }
        }


    }

    @Override
    public void deleteOrderDetails(OrderInfo orderInfo) {
        Session session = this.sessionFactory.getCurrentSession();

        List<OrderDetailInfo> orderDetails = orderInfo.getDetails();
        if (orderDetails != null) {
            for (OrderDetailInfo orderDetailInfo : orderDetails) {
                OrderDetail orderDetail = this.findOrderDetail(orderDetailInfo.getId());
                if (orderDetail != null) {
                    session.delete(orderDetail);
                }
            }

        }
        // If error in DB, Exceptions will be thrown out immediately
        session.flush();
    }
}
