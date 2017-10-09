package hjon.company.modules.common.service;

import hjon.company.common.service.BaseService;
import hjon.company.modules.common.entity.CommonBanner;

import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CommonBannerService extends BaseService<CommonBanner> {
	public List<Map> findCommonBanner() {
		StringBuffer sql = new StringBuffer(
				"select cb.id,cb.name,ca.storepath from common_banner cb left join common_attachment ca on cb.id=ca.sourceId and ca.sourceEntity='COMMONBANNER' where cb.inUse=1");
		Session session = this.getSessionFactory().openSession();
		SQLQuery query = session.createSQLQuery(sql.toString());

		query.setResultTransformer(CriteriaSpecification.ALIAS_TO_ENTITY_MAP);
		List<Map> result = query.list();
		session.clear();
		return result;
	}
}
