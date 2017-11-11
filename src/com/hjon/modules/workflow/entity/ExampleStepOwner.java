package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfExamplestepowner entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_examplestepowner", catalog = "springmvc")
public class ExampleStepOwner implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer exampleid;
	private Integer examplestepid;
	private Integer ownerid;
	private Integer preownerid;
	private Integer status;
	private Date approvetime;
	private String approveopinion;
	private Integer approvestatus;
	private String approvebrief;
	private Date starttime;
	private Integer value;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ExampleStepOwner() {
	}

	/** minimal constructor */
	public ExampleStepOwner(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ExampleStepOwner(Integer id, Integer exampleid,
			Integer examplestepid, Integer ownerid, Integer preownerid,
			Integer status, Date approvetime, String approveopinion,
			Integer approvestatus, String approvebrief, Date starttime,
			Integer value, Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname) {
		this.id = id;
		this.exampleid = exampleid;
		this.examplestepid = examplestepid;
		this.ownerid = ownerid;
		this.preownerid = preownerid;
		this.status = status;
		this.approvetime = approvetime;
		this.approveopinion = approveopinion;
		this.approvestatus = approvestatus;
		this.approvebrief = approvebrief;
		this.starttime = starttime;
		this.value = value;
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

	@Column(name = "EXAMPLEID", precision = 65, scale = 30)
	public Integer getExampleid() {
		return this.exampleid;
	}

	public void setExampleid(Integer exampleid) {
		this.exampleid = exampleid;
	}

	@Column(name = "EXAMPLESTEPID", precision = 65, scale = 30)
	public Integer getExamplestepid() {
		return this.examplestepid;
	}

	public void setExamplestepid(Integer examplestepid) {
		this.examplestepid = examplestepid;
	}

	@Column(name = "OWNERID", precision = 65, scale = 30)
	public Integer getOwnerid() {
		return this.ownerid;
	}

	public void setOwnerid(Integer ownerid) {
		this.ownerid = ownerid;
	}

	@Column(name = "PREOWNERID", precision = 65, scale = 30)
	public Integer getPreownerid() {
		return this.preownerid;
	}

	public void setPreownerid(Integer preownerid) {
		this.preownerid = preownerid;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "APPROVETIME", length = 19)
	public Date getApprovetime() {
		return this.approvetime;
	}

	public void setApprovetime(Date approvetime) {
		this.approvetime = approvetime;
	}

	@Column(name = "APPROVEOPINION", length = 65535)
	public String getApproveopinion() {
		return this.approveopinion;
	}

	public void setApproveopinion(String approveopinion) {
		this.approveopinion = approveopinion;
	}

	@Column(name = "APPROVESTATUS", precision = 65, scale = 30)
	public Integer getApprovestatus() {
		return this.approvestatus;
	}

	public void setApprovestatus(Integer approvestatus) {
		this.approvestatus = approvestatus;
	}

	@Column(name = "APPROVEBRIEF", length = 200)
	public String getApprovebrief() {
		return this.approvebrief;
	}

	public void setApprovebrief(String approvebrief) {
		this.approvebrief = approvebrief;
	}

	@Column(name = "STARTTIME", length = 19)
	public Date getStarttime() {
		return this.starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	@Column(name = "VALUE", precision = 65, scale = 30)
	public Integer getValue() {
		return this.value;
	}

	public void setValue(Integer value) {
		this.value = value;
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