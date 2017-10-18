package com.hjon.modules.homepage.service;

import com.hjon.common.service.BaseService;
import com.hjon.modules.homepage.entity.Product;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ProductService extends BaseService<Product> {

}
