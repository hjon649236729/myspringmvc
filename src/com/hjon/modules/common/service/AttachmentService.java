package com.hjon.modules.common.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.common.entity.Attachment;

@Service
@Transactional
public class AttachmentService extends BaseService<Attachment> {
	public List<Attachment> findAttachmentList(String sourceEntity) {
		List<Attachment> AttachmentList = this.query(
				"from Attachment where sourceEntity=?",
				new Object[] { sourceEntity });
		return AttachmentList;
	}

	public List<Attachment> findAttachmentList(String sourceEntity,
			String sourceId) {
		List<Attachment> AttachmentList = this.query(
				"from Attachment where sourceEntity=? and sourceid=?",
				new Object[] { sourceEntity, sourceId });
		return AttachmentList;
	}

	public List<Attachment> findAttachmentList(String sourceEntity,
			int sourceId, int type) {
		List<Attachment> AttachmentList = this.query(
				"from Attachment where sourceEntity=? and sourceId=?",
				new Object[] { sourceEntity, sourceId });
		return AttachmentList;
	}
}
