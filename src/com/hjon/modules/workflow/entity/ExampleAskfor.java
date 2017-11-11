package com.hjon.modules.workflow.entity;

import java.util.Date;
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

	private Integer id;
	private Integer askerid;
	private Integer parentid;
	private Integer exampleownerid;
	private Integer ownerid;
	private Integer status;
	private Date starttime;
	private Date approvetime;
	private Integer approvestatus;
	private String opinion;
	private String brief;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ExampleAskfor() {
	}

	/** minimal constructor */
	public ExampleAskfor(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ExampleAskfor(Integer id, Integer askerid, Integer parentid,
			Integer exampleownerid, Integer ownerid, Integer status,
			Date starttime, Date approvetime, Integer approvestatus,
			String opinion, String brief, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
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
	@Column(name = "Id", unique = true, nullable = false, precision = 65, scale = 30)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
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
	public Date getStarttime() {
		return this.starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	@Column(name = "APPROVETIME", length = 19)
	public Date getApprovetime() {
		return this.approvetime;
	}

	public void setApprovetime(Date approvetime) {
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