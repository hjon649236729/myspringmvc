package com.hjon.modules.workflow.entity;

import java.util.Date;
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

	private Integer id;
	private String targettype;
	private Integer targetid;
	private String targetadd;
	private Integer ruleid;
	private Integer status;
	private String brief;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ProcessRule() {
	}

	/** minimal constructor */
	public ProcessRule(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessRule(Integer id, String targettype, Integer targetid,
			String targetadd, Integer ruleid, Integer status, String brief,
			Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname) {
		this.id = id;
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
	@Column(name = "Id", unique = true, nullable = false, precision = 65, scale = 30)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
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
	public Date getCreatetimestamp() {
		return this.createtimestamp;
	}

	public void setCreatetimestamp(Date createtimestamp) {
		this.createtimestamp = createtimestamp;
	}

	@Column(name = "UPDATETIMESTAMP", nullable = false, length = 19)
	public Date getUpdatetimestamp() {
		return this.updatetimestamp;
	}

	public void setUpdatetimestamp(Date updatetimestamp) {
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