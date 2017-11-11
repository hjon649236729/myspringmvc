package com.hjon.modules.workflow.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcesssteplinkif entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processsteplinkif", catalog = "springmvc")
public class ProcessStepLinkIf implements java.io.Serializable {

	// Fields

	private Integer objid;
	private Integer linkid;
	private Integer processid;
	private Integer iftype;
	private Integer stepid;
	private Integer ifand;
	private String ifads;
	private Integer status;
	private Timestamp createtimestamp;
	private Timestamp updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ProcessStepLinkIf() {
	}

	/** minimal constructor */
	public ProcessStepLinkIf(Integer objid, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessStepLinkIf(Integer objid, Integer linkid, Integer processid,
			Integer iftype, Integer stepid, Integer ifand, String ifads,
			Integer status, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.linkid = linkid;
		this.processid = processid;
		this.iftype = iftype;
		this.stepid = stepid;
		this.ifand = ifand;
		this.ifads = ifads;
		this.status = status;
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

	@Column(name = "LINKID", precision = 65, scale = 30)
	public Integer getLinkid() {
		return this.linkid;
	}

	public void setLinkid(Integer linkid) {
		this.linkid = linkid;
	}

	@Column(name = "PROCESSID", precision = 65, scale = 30)
	public Integer getProcessid() {
		return this.processid;
	}

	public void setProcessid(Integer processid) {
		this.processid = processid;
	}

	@Column(name = "IFTYPE", precision = 65, scale = 30)
	public Integer getIftype() {
		return this.iftype;
	}

	public void setIftype(Integer iftype) {
		this.iftype = iftype;
	}

	@Column(name = "STEPID", precision = 65, scale = 30)
	public Integer getStepid() {
		return this.stepid;
	}

	public void setStepid(Integer stepid) {
		this.stepid = stepid;
	}

	@Column(name = "IFAND", precision = 65, scale = 30)
	public Integer getIfand() {
		return this.ifand;
	}

	public void setIfand(Integer ifand) {
		this.ifand = ifand;
	}

	@Column(name = "IFADS", length = 200)
	public String getIfads() {
		return this.ifads;
	}

	public void setIfads(String ifads) {
		this.ifads = ifads;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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