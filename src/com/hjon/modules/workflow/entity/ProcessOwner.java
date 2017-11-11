package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcessowner entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processowner", catalog = "springmvc")
public class ProcessOwner implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer value;
	private Integer ownergoto;
	private Integer ownergotoid;
	private Integer processid;
	private Integer stepid;
	private String orgid;
	private Integer orgtype;
	private Integer status;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ProcessOwner() {
	}

	/** minimal constructor */
	public ProcessOwner(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessOwner(Integer id, Integer value, Integer ownergoto,
			Integer ownergotoid, Integer processid, Integer stepid, String orgid,
			Integer orgtype, Integer status, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.value = value;
		this.ownergoto = ownergoto;
		this.ownergotoid = ownergotoid;
		this.processid = processid;
		this.stepid = stepid;
		this.orgid = orgid;
		this.orgtype = orgtype;
		this.status = status;
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

	@Column(name = "VALUE", precision = 65, scale = 30)
	public Integer getValue() {
		return this.value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}

	@Column(name = "OWNERGOTO", precision = 65, scale = 30)
	public Integer getOwnergoto() {
		return this.ownergoto;
	}

	public void setOwnergoto(Integer ownergoto) {
		this.ownergoto = ownergoto;
	}

	@Column(name = "OWNERGOTOID", precision = 65, scale = 30)
	public Integer getOwnergotoid() {
		return this.ownergotoid;
	}

	public void setOwnergotoid(Integer ownergotoid) {
		this.ownergotoid = ownergotoid;
	}

	@Column(name = "PROCESSID", precision = 65, scale = 30)
	public Integer getProcessid() {
		return this.processid;
	}

	public void setProcessid(Integer processid) {
		this.processid = processid;
	}

	@Column(name = "STEPID", precision = 65, scale = 30)
	public Integer getStepid() {
		return this.stepid;
	}

	public void setStepid(Integer stepid) {
		this.stepid = stepid;
	}

	@Column(name = "ORGID", length = 20)
	public String getOrgid() {
		return this.orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	@Column(name = "ORGTYPE", precision = 65, scale = 30)
	public Integer getOrgtype() {
		return this.orgtype;
	}

	public void setOrgtype(Integer orgtype) {
		this.orgtype = orgtype;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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