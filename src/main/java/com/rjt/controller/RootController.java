package com.rjt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.rjt.model.CartInfo;
import com.rjt.utils.Utils;

import javax.servlet.http.HttpServletRequest;

@Controller
public class RootController {

    @ModelAttribute("cartSize")
    public int getCartSize(HttpServletRequest request) {
        CartInfo cartInfo = Utils.getCartInSession(request);
        return cartInfo.getCartLines().size();
    }

}
