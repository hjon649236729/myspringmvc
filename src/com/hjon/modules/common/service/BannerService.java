package com.hjon.modules.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.hibernate.criterion.CriteriaSpecification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.common.entity.Banner;

@Service
@Transactional
public class BannerService extends BaseService<Banner> {
	public List<Map<String, Object>> findBanner() {
		StringBuffer sql = new StringBuffer(
				"select cb.id,cb.name,ca.storepath from common_banner cb left join common_attachment ca on cb.id=ca.sourceId and ca.sourceEntity='Banner' where cb.inUse=1");
		SQLQuery query = this.createSqlQuery(sql.toString(),
				new HashMap<String, Object>());

		query.setResultTransformer(CriteriaSpecification.ALIAS_TO_ENTITY_MAP);
		List<Map<String, Object>> result = query.list();
		return result;
	}
}
