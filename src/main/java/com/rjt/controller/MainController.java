package com.rjt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.rjt.dao.AccountDAO;
import com.rjt.dao.CustomerDAO;
import com.rjt.dao.OrderDAO;
import com.rjt.dao.ProductDAO;
import com.rjt.entity.CustomerTable;
import com.rjt.entity.Product;
import com.rjt.model.AccountInfo;
import com.rjt.model.CartInfo;
import com.rjt.model.CustomerInfo;
import com.rjt.model.PaginationResult;
import com.rjt.model.ProductInfo;
import com.rjt.service.SecurityService;
import com.rjt.utils.Utils;
import com.rjt.validator.CustomerInfoValidator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
// Enable Hibernate Transaction.
@Transactional
// Need to use RedirectAttributes
@EnableWebMvc
public class MainController extends RootController {

    @Autowired
    private OrderDAO orderDAO;

    @Autowired
    private ProductDAO productDAO;
    
    @Autowired
    private AccountDAO accountDAO;
    
    @Autowired
    private CustomerDAO customerDAO;

    @Autowired
    private CustomerInfoValidator customerInfoValidator;

    @Autowired
    private SecurityService securityService;

    @InitBinder
    public void myInitBinder(WebDataBinder dataBinder) {
        Object target = dataBinder.getTarget();
        if (target == null) {
            return;
        }
        System.out.println("Target=" + target);

        // For Cart Form.
        // (@ModelAttribute("cartForm") @Validated CartInfo cartForm)
        if (target.getClass() == CartInfo.class) {

        }
        // For Customer Form.
        // (@ModelAttribute("customerForm") @Validated Customer
        // customerForm)
        else if (target.getClass() == CustomerInfo.class) {
            dataBinder.setValidator(customerInfoValidator);
        }

    }

    @RequestMapping("/403")
    public String accessDenied() {
        return "/403";
    }

    @RequestMapping("/")
    public String home() {
        return "index";
    }
    
   /* @RequestMapping("/register")
    public String registerPage(Model model){
        AccountInfo accountInfo=new AccountInfo();
        model.addAttribute("accountForm", accountInfo);
    	return "shoppingRegister";
    }*/
    @RequestMapping("/register")
    public String registerPage(Model model, HttpServletRequest request){
        CustomerInfo customerInfo=new CustomerInfo();
        model.addAttribute("customerForm", customerInfo);
        String message=(String) request.getAttribute("message");
        model.addAttribute("message",message);
    	return "shoppingRegister";
    }
    
    @RequestMapping(value = {"/registerSave"}, method = RequestMethod.POST)
    public String register(HttpServletRequest request, //
                                           Model model, //
                                           @ModelAttribute("customerForm") @Validated CustomerInfo customerForm, //
                                           BindingResult result, //
                                           final RedirectAttributes redirectAttributes) {

        // If has Errors.
        if (result.hasErrors()) {
           customerForm.setValid(false);
           /* CustomerInfo customerInfo=new CustomerInfo();
            customerInfo.setValid(false);
            model.addAttribute("customerForm", customerInfo);*/
            return "shoppingRegister";
        }

        String message=accountDAO.saveAccount(customerForm.getUsername(), true, customerForm.getPassword(), "CUSTOMER");
        String message2=accountDAO.saveCustomer(customerForm.getUsername(),customerForm.getName(), customerForm.getAddress(), customerForm.getEmail(), customerForm.getPhone());
        request.setAttribute("message", message);
        System.out.println("message is "+message);

        // Redirect to Confirmation page.
        return "shoppingRegister";
    }
    
/*    @RequestMapping(value={"/registerSave"}, method = RequestMethod.POST)
    	public String register(HttpServletRequest request, //
                Model model, //
                @ModelAttribute("accountForm") @Validated AccountInfo accountForm, //
                BindingResult result, //
                final RedirectAttributes redirectAttributes){
    	// If has Errors.
        if (result.hasErrors()) {
            accountForm.setValid(false);
            // Forward to reenter customer info.
            return "shoppingRegister";
        }
        
        String message=accountDAO.saveAccount(accountForm.getUsername(), true, accountForm.getPassword(), "CUSTOMER");
       //String message2=accountDAO.saveCustomer(customerForm.getName(), customerForm.getAddress(), customerForm.getEmail(), customerForm.getPhone());
       model.addAttribute("message", message);
       System.out.println("message is "+message);
        // Redirect to Confirmation page.
        return "shoppingRegister";
    		
    	}*/
    

    // Product List page.
    @RequestMapping({"/productList"})
    public String listProductHandler(Model model, //
                                     @RequestParam(value = "name", defaultValue = "") String likeName, 
                                     @RequestParam(value = "category", defaultValue = "") String catName,
                                     @RequestParam(value = "page", defaultValue = "1") int page) {
        final int maxResult = 5;
        final int maxNavigationPage = 10;
        System.out.println("catName: "+catName);
        PaginationResult<ProductInfo> result = productDAO.queryProducts(page, //
                maxResult, maxNavigationPage, likeName, catName);

        model.addAttribute("paginationProducts", result);
        return "productList";
    }

    @RequestMapping({"/buyProduct"})
    public String listProductHandler(HttpServletRequest request, Model model, //
                                     @RequestParam(value = "code", defaultValue = "") String code) {

        Product product = null;
        if (code != null && code.length() > 0) {
            product = productDAO.findProduct(code);
        }
        if (product != null) {

            // Cart info stored in Session.
            CartInfo cartInfo = Utils.getCartInSession(request);

            ProductInfo productInfo = new ProductInfo(product);

            cartInfo.addProduct(productInfo, 1);
        }
        // Redirect to shoppingCart page.
        return "redirect:/shoppingCart";
    }

    @RequestMapping({"/shoppingCartRemoveProduct"})
    public String removeProductHandler(HttpServletRequest request, Model model, //
                                       @RequestParam(value = "code", defaultValue = "") String code) {
        Product product = null;
        if (code != null && code.length() > 0) {
            product = productDAO.findProduct(code);
        }
        if (product != null) {

            // Cart Info stored in Session.
            CartInfo cartInfo = Utils.getCartInSession(request);

            ProductInfo productInfo = new ProductInfo(product);

            cartInfo.removeProduct(productInfo);

        }
        // Redirect to shoppingCart page.
        return "redirect:/shoppingCart";
    }

    // Update quantity of product in cart.
    @RequestMapping({"/shoppingCartUpdateProduct"})
    public String updateProductHandler(HttpServletRequest request, //
                                       Model model, //
                                       @RequestParam(value = "code", defaultValue = "") String code,
                                       @RequestParam(value = "qty", defaultValue = "1") int qty) {

        Product product = null;
        if (code != null && code.length() > 0) {
            product = productDAO.findProduct(code);
        }
        if (product != null) {

            // Cart Info stored in Session.
            CartInfo cartInfo = Utils.getCartInSession(request);
            cartInfo.updateProduct(code, qty);

        }
        // Redirect to shoppingCart page.
        return "redirect:/shoppingCart";
    }

    // POST: Update quantity of products in cart.
    @RequestMapping(value = {"/shoppingCart"}, method = RequestMethod.POST)
    public String shoppingCartUpdateQty(HttpServletRequest request, //
                                        Model model, //
                                        @ModelAttribute("cartForm") CartInfo cartForm) {

        CartInfo cartInfo = Utils.getCartInSession(request);
        cartInfo.updateQuantity(cartForm);

        // Redirect to shoppingCart page.
        return "redirect:/shoppingCart";
    }

    // GET: Show Cart
    @RequestMapping(value = {"/shoppingCart"}, method = RequestMethod.GET)
    public String shoppingCartHandler(HttpServletRequest request, Model model) {
        CartInfo myCart = Utils.getCartInSession(request);

        model.addAttribute("cartForm", myCart);
        return "shoppingCart";
    }

    // GET: Go to check out customer information.
    @RequestMapping(value = {"/shoppingCartCustomer"}, method = RequestMethod.GET)
    public String shoppingCartCustomerForm(HttpServletRequest request, Model model) {

        CartInfo cartInfo = Utils.getCartInSession(request);

        // Cart is empty.
        if (cartInfo.isEmpty()) {

            // Redirect to shoppingCart page.
            return "redirect:/shoppingCart";
        }

        CustomerInfo customerInfo = cartInfo.getCustomerInfo();
        if (customerInfo == null) {
            
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String name = auth.getName(); //get logged in username
            CustomerTable customer=customerDAO.findCustomer(name);
            customerInfo = new CustomerInfo(customer.getName(),customer.getAddress(),customer.getEmail(),customer.getPhone());
            customerInfo.setValid(true);
            cartInfo = Utils.getCartInSession(request);
            cartInfo.setCustomerInfo(customerInfo);
        }

        model.addAttribute("customerForm", customerInfo);

        //return "shoppingCartCustomer";
        return "shoppingCartConfirmation";
    }
    
 // GET: Edit customer information.
    @RequestMapping(value = {"/shoppingCartCustomerEdit"}, method = RequestMethod.GET)
    public String shoppingCartCustomerFormEdit(HttpServletRequest request, Model model) {

        CartInfo cartInfo = Utils.getCartInSession(request);

        // Cart is empty.
        if (cartInfo.isEmpty()) {

            // Redirect to shoppingCart page.
            return "redirect:/shoppingCart";
        }

        CustomerInfo customerInfo = cartInfo.getCustomerInfo();
        if (customerInfo == null) {
            customerInfo = new CustomerInfo();
        }

        model.addAttribute("customerForm", customerInfo);

        return "shoppingCartCustomer";
    }

    // POST: Save customer information.
    @RequestMapping(value = {"/shoppingCartCustomer"}, method = RequestMethod.POST)
    public String shoppingCartCustomerSave(HttpServletRequest request, //
                                           Model model, //
                                           @ModelAttribute("customerForm") @Validated CustomerInfo customerForm, //
                                           BindingResult result, //
                                           final RedirectAttributes redirectAttributes) {

        // If has Errors.
        if (result.hasErrors()) {
            customerForm.setValid(false);
            // Forward to reenter customer info.
            return "shoppingCartCustomer";
        }

        customerForm.setValid(true);
        CartInfo cartInfo = Utils.getCartInSession(request);
        cartInfo.setCustomerInfo(customerForm);
        // Redirect to Confirmation page.
        return "redirect:/shoppingCartConfirmation";
    }

    // GET: Review Cart to confirm.
    @RequestMapping(value = {"/shoppingCartConfirmation"}, method = RequestMethod.GET)
    public String shoppingCartConfirmationReview(HttpServletRequest request, Model model) {
        CartInfo cartInfo = Utils.getCartInSession(request);

        // Cart have no products.
        if (cartInfo.isEmpty()) {
            // Redirect to shoppingCart page.
            return "redirect:/shoppingCart";
        } else if (!cartInfo.isValidCustomer()) {
            // Enter customer info.
            return "redirect:/shoppingCartCustomer";
        }

        return "shoppingCartConfirmation";
    }

    // POST: Send Cart (Save).
    @RequestMapping(value = {"/shoppingCartConfirmation"}, method = RequestMethod.POST)
    // Avoid UnexpectedRollbackException (See more explanations)
    @Transactional(propagation = Propagation.NEVER)
    public String shoppingCartConfirmationSave(HttpServletRequest request, Model model) {
        CartInfo cartInfo = Utils.getCartInSession(request);

        // Cart have no products.
        if (cartInfo.isEmpty()) {
            // Redirect to shoppingCart page.
            return "redirect:/shoppingCart";
        } else if (!cartInfo.isValidCustomer()) {
            // Enter customer info.
            return "redirect:/shoppingCartCustomer";
        }
        try {
            orderDAO.saveOrder(cartInfo);
        } catch (Exception e) {
            // Need: Propagation.NEVER?
            return "shoppingCartConfirmation";
        }
        // Remove Cart In Session.
        Utils.removeCartInSession(request);

        // Store Last ordered cart to Session.
        Utils.storeLastOrderedCartInSession(request, cartInfo);

        // Redirect to successful page.
        return "redirect:/shoppingCartFinalize";
    }

    @RequestMapping(value = {"/shoppingCartFinalize"}, method = RequestMethod.GET)
    public String shoppingCartFinalize(HttpServletRequest request, Model model) {

        CartInfo lastOrderedCart = Utils.getLastOrderedCartInSession(request);

        if (lastOrderedCart == null) {
            return "redirect:/shoppingCart";
        }

        return "shoppingCartFinalize";
    }

    @RequestMapping(value = {"/productImage"}, method = RequestMethod.GET)
    public void productImage(HttpServletRequest request, HttpServletResponse response, Model model,
                             @RequestParam("code") String code) throws IOException {
        Product product = null;
        if (code != null) {
            product = this.productDAO.findProduct(code);
        }
        if (product != null && product.getImage() != null) {
            response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
            response.getOutputStream().write(product.getImage());
        }
        response.getOutputStream().close();
    }

    @RequestMapping(value = {"/autoLogin"}, method = RequestMethod.GET)
    public String autoLogin(Model model, @RequestParam("login") String login, @RequestParam("pass") String password) {
        if (login != null && password != null && login.length() > 0 && password.length() > 0) {
            securityService.autoLogin(login, password);
        }
        return "redirect:/accountInfo";
    }

    @RequestMapping(value = {"/productInfo"}, method = RequestMethod.GET)
    public String productInfo(Model model, @RequestParam(value = "code", defaultValue = "") String code) {
        ProductInfo productInfo = null;
        if (code != null && code.length() > 0) {
            productInfo = productDAO.findProductInfo(code);
        }
        if (productInfo == null) {
            return "redirect:/productList";
        }
        model.addAttribute("productInfo", productInfo);
        return "productInfo";
    }
}
