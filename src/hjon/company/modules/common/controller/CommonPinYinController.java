package hjon.company.modules.common.controller;

import hjon.company.common.controller.BaseController;
import hjon.company.common.utils.PinYinHelper;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Scope("prototype")
public class CommonPinYinController extends BaseController {
	@RequestMapping("common/pinyin/getPinYin")
	public void getPinYin() {
		String p = this.getParameter("val");
		String result="";
		if (p != null || !"".equals(p)) {
			String fullPinYin=PinYinHelper.getInstance().getFullPinYin(p);
			String shortPinYin=PinYinHelper.getInstance().getSimplePinYin(p);
			result="{fullPinYin:'"+fullPinYin+"',"+"shortPinYin:'"+shortPinYin+"'}";
		}else{
			result="{fullPinYin:'',shortPinYin:''}";
		}
		this.outputText(result);
	}
}
