package com.hjon.modules.workflow.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hjon.common.controller.BaseController;

@Controller
@Scope("prototype")
public class RaphaleController extends BaseController {
	@RequestMapping("workflow/raphaledemo")
	public String raphaledemo() {

		return "workflow/raphaledemo";
	}

}
