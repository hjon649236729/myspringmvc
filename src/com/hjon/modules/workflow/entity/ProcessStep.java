package com.hjon.modules.workflow.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcessstep entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processstep", catalog = "springmvc")
public class ProcessStep implements java.io.Serializable {

	// Fields

	private Integer objid;
	private Integer status;
	private Integer processid;
	private String name;
	private Integer steptypeid;
	private String steptypeads;
	private String condition;
	private String actionurl;
	private String showurl;
	private Integer sort;
	private Integer urlmark;
	private Timestamp createtimestamp;
	private Timestamp updatetimestamp;
	private Integer version;
	private String entityname;
	private Integer pointtypeid;
	private Integer stepcode;
	private String stepspecial;
	private Integer branchstepid;
	private Integer phoneshow;
	private Integer agenttype;

	// Constructors

	/** default constructor */
	public ProcessStep() {
	}

	/** minimal constructor */
	public ProcessStep(Integer objid, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessStep(Integer objid, Integer status, Integer processid,
			String name, Integer steptypeid, String steptypeads,
			String condition, String actionurl, String showurl, Integer sort,
			Integer urlmark, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname,
			Integer pointtypeid, Integer stepcode, String stepspecial,
			Integer branchstepid, Integer phoneshow, Integer agenttype) {
		this.objid = objid;
		this.status = status;
		this.processid = processid;
		this.name = name;
		this.steptypeid = steptypeid;
		this.steptypeads = steptypeads;
		this.condition = condition;
		this.actionurl = actionurl;
		this.showurl = showurl;
		this.sort = sort;
		this.urlmark = urlmark;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
		this.pointtypeid = pointtypeid;
		this.stepcode = stepcode;
		this.stepspecial = stepspecial;
		this.branchstepid = branchstepid;
		this.phoneshow = phoneshow;
		this.agenttype = agenttype;
	}

	// Property accessors
	@Id
	@Column(name = "OBJID", unique = true, nullable = false, precision = 65, scale = 30)
	public Integer getObjid() {
		return this.objid;
	}

	public void setObjid(Integer objid) {
		this.objid = objid;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "PROCESSID", precision = 65, scale = 30)
	public Integer getProcessid() {
		return this.processid;
	}

	public void setProcessid(Integer processid) {
		this.processid = processid;
	}

	@Column(name = "NAME", length = 100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "STEPTYPEID", precision = 65, scale = 30)
	public Integer getSteptypeid() {
		return this.steptypeid;
	}

	public void setSteptypeid(Integer steptypeid) {
		this.steptypeid = steptypeid;
	}

	@Column(name = "STEPTYPEADS", length = 200)
	public String getSteptypeads() {
		return this.steptypeads;
	}

	public void setSteptypeads(String steptypeads) {
		this.steptypeads = steptypeads;
	}

	@Column(name = "CONDITION", length = 65535)
	public String getCondition() {
		return this.condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	@Column(name = "ACTIONURL", length = 200)
	public String getActionurl() {
		return this.actionurl;
	}

	public void setActionurl(String actionurl) {
		this.actionurl = actionurl;
	}

	@Column(name = "SHOWURL", length = 200)
	public String getShowurl() {
		return this.showurl;
	}

	public void setShowurl(String showurl) {
		this.showurl = showurl;
	}

	@Column(name = "SORT", precision = 65, scale = 30)
	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@Column(name = "URLMARK", precision = 65, scale = 30)
	public Integer getUrlmark() {
		return this.urlmark;
	}

	public void setUrlmark(Integer urlmark) {
		this.urlmark = urlmark;
	}

	@Column(name = "CREATETIMESTAMP", nullable = false, length = 19)
	public Timestamp getCreatetimestamp() {
		return this.createtimestamp;
	}

	public void setCreatetimestamp(Timestamp createtimestamp) {
		this.createtimestamp = createtimestamp;
	}

	@Column(name = "UPDATETIMESTAMP", nullable = false, length = 19)
	public Timestamp getUpdatetimestamp() {
		return this.updatetimestamp;
	}

	public void setUpdatetimestamp(Timestamp updatetimestamp) {
		this.updatetimestamp = updatetimestamp;
	}

	@Column(name = "VERSION", nullable = false, precision = 65, scale = 30)
	public Integer getVersion() {
		return this.version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	@Column(name = "ENTITYNAME", nullable = false, length = 24)
	public String getEntityname() {
		return this.entityname;
	}

	public void setEntityname(String entityname) {
		this.entityname = entityname;
	}

	@Column(name = "POINTTYPEID", precision = 65, scale = 30)
	public Integer getPointtypeid() {
		return this.pointtypeid;
	}

	public void setPointtypeid(Integer pointtypeid) {
		this.pointtypeid = pointtypeid;
	}

	@Column(name = "STEPCODE", precision = 65, scale = 30)
	public Integer getStepcode() {
		return this.stepcode;
	}

	public void setStepcode(Integer stepcode) {
		this.stepcode = stepcode;
	}

	@Column(name = "STEPSPECIAL", length = 100)
	public String getStepspecial() {
		return this.stepspecial;
	}

	public void setStepspecial(String stepspecial) {
		this.stepspecial = stepspecial;
	}

	@Column(name = "BRANCHSTEPID", precision = 65, scale = 30)
	public Integer getBranchstepid() {
		return this.branchstepid;
	}

	public void setBranchstepid(Integer branchstepid) {
		this.branchstepid = branchstepid;
	}

	@Column(name = "PHONESHOW", precision = 65, scale = 30)
	public Integer getPhoneshow() {
		return this.phoneshow;
	}

	public void setPhoneshow(Integer phoneshow) {
		this.phoneshow = phoneshow;
	}

	@Column(name = "AGENTTYPE", precision = 65, scale = 30)
	public Integer getAgenttype() {
		return this.agenttype;
	}

	public void setAgenttype(Integer agenttype) {
		this.agenttype = agenttype;
	}

}