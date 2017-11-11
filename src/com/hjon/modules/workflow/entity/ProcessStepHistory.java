package com.hjon.modules.workflow.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcessstephistory entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processstephistory", catalog = "springmvc")
public class ProcessStepHistory implements java.io.Serializable {

	// Fields

	private Integer objid;
	private Integer prestepid;
	private Integer preprocessid;
	private Integer newprocessid;
	private Integer newstepid;
	private Timestamp createtimestamp;
	private Timestamp updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ProcessStepHistory() {
	}

	/** minimal constructor */
	public ProcessStepHistory(Integer objid, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessStepHistory(Integer objid, Integer prestepid,
			Integer preprocessid, Integer newprocessid, Integer newstepid,
			Timestamp createtimestamp, Timestamp updatetimestamp,
			Integer version, String entityname) {
		this.objid = objid;
		this.prestepid = prestepid;
		this.preprocessid = preprocessid;
		this.newprocessid = newprocessid;
		this.newstepid = newstepid;
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

	@Column(name = "PRESTEPID", precision = 65, scale = 30)
	public Integer getPrestepid() {
		return this.prestepid;
	}

	public void setPrestepid(Integer prestepid) {
		this.prestepid = prestepid;
	}

	@Column(name = "PREPROCESSID", precision = 65, scale = 30)
	public Integer getPreprocessid() {
		return this.preprocessid;
	}

	public void setPreprocessid(Integer preprocessid) {
		this.preprocessid = preprocessid;
	}

	@Column(name = "NEWPROCESSID", precision = 65, scale = 30)
	public Integer getNewprocessid() {
		return this.newprocessid;
	}

	public void setNewprocessid(Integer newprocessid) {
		this.newprocessid = newprocessid;
	}

	@Column(name = "NEWSTEPID", precision = 65, scale = 30)
	public Integer getNewstepid() {
		return this.newstepid;
	}

	public void setNewstepid(Integer newstepid) {
		this.newstepid = newstepid;
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