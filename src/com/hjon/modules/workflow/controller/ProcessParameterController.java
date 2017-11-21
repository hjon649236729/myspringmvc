package com.hjon.modules.workflow.controller;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hjon.common.controller.BaseController;
import com.hjon.modules.workflow.service.ProcessUrlService;

@Controller
@Scope("prototype")
public class ProcessParameterController extends BaseController {
	@Resource(name = "processUrlService")
	private ProcessUrlService processUrlService;
	@RequestMapping("workflow/processparameterlist")
	public String processparameterlist() {
		
		
		return "workflow/processparameterlist";
	}
	
}
