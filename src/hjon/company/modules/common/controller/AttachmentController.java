package hjon.company.modules.common.controller;

import hjon.company.common.controller.BaseController;
import hjon.company.modules.common.entity.CommonAttachment;
import hjon.company.modules.common.service.CommonAttachmentService;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

@Controller
@Scope("prototype")
public class AttachmentController extends BaseController {
	@Resource(name = "commonAttachmentService")
	private CommonAttachmentService commonAttachmentService;

	@RequestMapping("common/attachment/showlist")
	public void showlist() {
		String sourceEntity = request.getParameter("sourceEntity");
		String sourceId = request.getParameter("sourceId");
		List<CommonAttachment> attachmentList = commonAttachmentService
				.findCommonAttachmentList(sourceEntity, sourceId);
		Gson gson = new Gson();
		this.outputText(gson.toJson(attachmentList));
	}

}
