package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfApproverela entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_approverela", catalog = "springmvc")
public class ApproveRela implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer callerid;
	private Integer workflowtype;
	private Integer inputid;
	private Integer type;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ApproveRela() {
	}

	/** minimal constructor */
	public ApproveRela(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ApproveRela(Integer id, Integer callerid, Integer workflowtype,
			Integer inputid, Integer type, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.callerid = callerid;
		this.workflowtype = workflowtype;
		this.inputid = inputid;
		this.type = type;
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

	@Column(name = "CALLERID", precision = 65, scale = 30)
	public Integer getCallerid() {
		return this.callerid;
	}

	public void setCallerid(Integer callerid) {
		this.callerid = callerid;
	}

	@Column(name = "WORKFLOWTYPE", precision = 65, scale = 30)
	public Integer getWorkflowtype() {
		return this.workflowtype;
	}

	public void setWorkflowtype(Integer workflowtype) {
		this.workflowtype = workflowtype;
	}

	@Column(name = "INPUTID", precision = 65, scale = 30)
	public Integer getInputid() {
		return this.inputid;
	}

	public void setInputid(Integer inputid) {
		this.inputid = inputid;
	}

	@Column(name = "TYPE", precision = 65, scale = 30)
	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
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