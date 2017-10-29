package com.hjon.modules.common.contorller;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hjon.common.controller.BaseController;
import com.hjon.modules.auth.controller.UserInfoController;
@Controller
@Scope("prototype")
public class SysMenuController extends BaseController {
	Logger logger=Logger.getLogger(UserInfoController.class);
	@RequestMapping("common/sysmenumain")
	public String sysmenumain(){
		
		return "common/sysmenu/sysmenumain";
		
	}
	
	@RequestMapping("common/sysmenulist")
	public String sysmenulist(){
		
		return "common/sysmenu/sysmenulist";
		
	}
	@RequestMapping("common/sysmenutree")
	public String sysmenutree(){
		
		return "common/sysmenu/sysmenutree";
		
	}
}
