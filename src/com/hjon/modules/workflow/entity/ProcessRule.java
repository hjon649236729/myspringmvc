package com.hjon.modules.workflow.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcessrule entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processrule", catalog = "springmvc")
public class ProcessRule implements java.io.Serializable {

	// Fields

	private Integer objid;
	private String targettype;
	private Integer targetid;
	private String targetadd;
	private Integer ruleid;
	private Integer status;
	private String brief;
	private Timestamp createtimestamp;
	private Timestamp updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ProcessRule() {
	}

	/** minimal constructor */
	public ProcessRule(Integer objid, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessRule(Integer objid, String targettype, Integer targetid,
			String targetadd, Integer ruleid, Integer status, String brief,
			Timestamp createtimestamp, Timestamp updatetimestamp,
			Integer version, String entityname) {
		this.objid = objid;
		this.targettype = targettype;
		this.targetid = targetid;
		this.targetadd = targetadd;
		this.ruleid = ruleid;
		this.status = status;
		this.brief = brief;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
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

	@Column(name = "TARGETTYPE", length = 30)
	public String getTargettype() {
		return this.targettype;
	}

	public void setTargettype(String targettype) {
		this.targettype = targettype;
	}

	@Column(name = "TARGETID", precision = 65, scale = 30)
	public Integer getTargetid() {
		return this.targetid;
	}

	public void setTargetid(Integer targetid) {
		this.targetid = targetid;
	}

	@Column(name = "TARGETADD", length = 200)
	public String getTargetadd() {
		return this.targetadd;
	}

	public void setTargetadd(String targetadd) {
		this.targetadd = targetadd;
	}

	@Column(name = "RULEID", precision = 65, scale = 30)
	public Integer getRuleid() {
		return this.ruleid;
	}

	public void setRuleid(Integer ruleid) {
		this.ruleid = ruleid;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "BRIEF", length = 200)
	public String getBrief() {
		return this.brief;
	}

	public void setBrief(String brief) {
		this.brief = brief;
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

}