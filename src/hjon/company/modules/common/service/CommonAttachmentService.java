package hjon.company.modules.common.service;

import hjon.company.common.service.BaseService;
import hjon.company.modules.common.entity.CommonAttachment;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CommonAttachmentService extends BaseService<CommonAttachment> {
	public List<CommonAttachment> findCommonAttachmentList(String sourceEntity) {
		List<CommonAttachment> CommonAttachmentList = this.query(
				"from CommonAttachment where sourceEntity=?",
				new Object[] { sourceEntity });
		return CommonAttachmentList;
	}
	public List<CommonAttachment> findCommonAttachmentList(String sourceEntity,
			String sourceId) {
		List<CommonAttachment> CommonAttachmentList = this.query(
				"from CommonAttachment where sourceEntity=? and sourceid=?",
				new Object[] { sourceEntity, sourceId });
		return CommonAttachmentList;
	}

	public List<CommonAttachment> findCommonAttachmentList(String sourceEntity,
			int sourceId, int type) {
		List<CommonAttachment> commonAttachmentList = this.query(
				"from CommonAttachment where sourceEntity=? and sourceId=?",
				new Object[] { sourceEntity, sourceId });
		return commonAttachmentList;
	}
}
