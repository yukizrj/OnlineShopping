package com.rjt.dao;

import com.rjt.entity.Product;
import com.rjt.model.PaginationResult;
import com.rjt.model.ProductInfo;

public interface ProductDAO {

    public Product findProduct(String code);

    public ProductInfo findProductInfo(String code);

    public PaginationResult<ProductInfo> queryProducts(int page, int maxResult, int maxNavigationPage);

    public PaginationResult<ProductInfo> queryProducts(int page, int maxResult, int maxNavigationPage, String likeName, String catName);

    public void save(ProductInfo productInfo);

    public void delete(String code);

}