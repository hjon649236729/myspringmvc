package com.hjon.modules.workflow.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfExampleaskfor entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_exampleaskfor", catalog = "springmvc")
public class ExampleAskfor implements java.io.Serializable {

	// Fields

	private Integer objid;
	private Integer askerid;
	private Integer parentid;
	private Integer exampleownerid;
	private Integer ownerid;
	private Integer status;
	private Timestamp starttime;
	private Timestamp approvetime;
	private Integer approvestatus;
	private String opinion;
	private String brief;
	private Timestamp createtimestamp;
	private Timestamp updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ExampleAskfor() {
	}

	/** minimal constructor */
	public ExampleAskfor(Integer objid, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ExampleAskfor(Integer objid, Integer askerid, Integer parentid,
			Integer exampleownerid, Integer ownerid, Integer status,
			Timestamp starttime, Timestamp approvetime, Integer approvestatus,
			String opinion, String brief, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.askerid = askerid;
		this.parentid = parentid;
		this.exampleownerid = exampleownerid;
		this.ownerid = ownerid;
		this.status = status;
		this.starttime = starttime;
		this.approvetime = approvetime;
		this.approvestatus = approvestatus;
		this.opinion = opinion;
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

	@Column(name = "ASKERID", precision = 65, scale = 30)
	public Integer getAskerid() {
		return this.askerid;
	}

	public void setAskerid(Integer askerid) {
		this.askerid = askerid;
	}

	@Column(name = "PARENTID", precision = 65, scale = 30)
	public Integer getParentid() {
		return this.parentid;
	}

	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}

	@Column(name = "EXAMPLEOWNERID", precision = 65, scale = 30)
	public Integer getExampleownerid() {
		return this.exampleownerid;
	}

	public void setExampleownerid(Integer exampleownerid) {
		this.exampleownerid = exampleownerid;
	}

	@Column(name = "OWNERID", precision = 65, scale = 30)
	public Integer getOwnerid() {
		return this.ownerid;
	}

	public void setOwnerid(Integer ownerid) {
		this.ownerid = ownerid;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "STARTTIME", length = 19)
	public Timestamp getStarttime() {
		return this.starttime;
	}

	public void setStarttime(Timestamp starttime) {
		this.starttime = starttime;
	}

	@Column(name = "APPROVETIME", length = 19)
	public Timestamp getApprovetime() {
		return this.approvetime;
	}

	public void setApprovetime(Timestamp approvetime) {
		this.approvetime = approvetime;
	}

	@Column(name = "APPROVESTATUS", precision = 65, scale = 30)
	public Integer getApprovestatus() {
		return this.approvestatus;
	}

	public void setApprovestatus(Integer approvestatus) {
		this.approvestatus = approvestatus;
	}

	@Column(name = "OPINION", length = 65535)
	public String getOpinion() {
		return this.opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
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