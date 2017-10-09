package hjon.company.modules.homepage.service;

import hjon.company.common.service.BaseService;
import hjon.company.modules.homepage.entity.Product;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ProductService extends BaseService<Product> {

}
