package com.hjon.modules.workflow.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcessownerlink entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processownerlink", catalog = "springmvc")
public class ProcessOwnerLink implements java.io.Serializable {

	// Fields

	private Integer objid;
	private String ownerstarter;
	private String ownerender;
	private Integer status;
	private Integer sort;
	private Integer linkroot;
	private Integer linkleaf;
	private Integer stepid;
	private Integer processid;
	private Timestamp createtimestamp;
	private Timestamp updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ProcessOwnerLink() {
	}

	/** minimal constructor */
	public ProcessOwnerLink(Integer objid, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessOwnerLink(Integer objid, String ownerstarter,
			String ownerender, Integer status, Integer sort, Integer linkroot,
			Integer linkleaf, Integer stepid, Integer processid,
			Timestamp createtimestamp, Timestamp updatetimestamp,
			Integer version, String entityname) {
		this.objid = objid;
		this.ownerstarter = ownerstarter;
		this.ownerender = ownerender;
		this.status = status;
		this.sort = sort;
		this.linkroot = linkroot;
		this.linkleaf = linkleaf;
		this.stepid = stepid;
		this.processid = processid;
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

	@Column(name = "OWNERSTARTER", length = 65535)
	public String getOwnerstarter() {
		return this.ownerstarter;
	}

	public void setOwnerstarter(String ownerstarter) {
		this.ownerstarter = ownerstarter;
	}

	@Column(name = "OWNERENDER", length = 65535)
	public String getOwnerender() {
		return this.ownerender;
	}

	public void setOwnerender(String ownerender) {
		this.ownerender = ownerender;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "SORT", precision = 65, scale = 30)
	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@Column(name = "LINKROOT", precision = 65, scale = 30)
	public Integer getLinkroot() {
		return this.linkroot;
	}

	public void setLinkroot(Integer linkroot) {
		this.linkroot = linkroot;
	}

	@Column(name = "LINKLEAF", precision = 65, scale = 30)
	public Integer getLinkleaf() {
		return this.linkleaf;
	}

	public void setLinkleaf(Integer linkleaf) {
		this.linkleaf = linkleaf;
	}

	@Column(name = "STEPID", precision = 65, scale = 30)
	public Integer getStepid() {
		return this.stepid;
	}

	public void setStepid(Integer stepid) {
		this.stepid = stepid;
	}

	@Column(name = "PROCESSID", precision = 65, scale = 30)
	public Integer getProcessid() {
		return this.processid;
	}

	public void setProcessid(Integer processid) {
		this.processid = processid;
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