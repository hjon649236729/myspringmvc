package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfExample entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_example", catalog = "springmvc")
public class Example implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer status;
	private Date endtime;
	private String starterads;
	private String brief;
	private Integer starterid;
	private Date starttime;
	private Integer processid;
	private String processname;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;
	private String datafrom;

	// Constructors

	/** default constructor */
	public Example() {
	}

	/** minimal constructor */
	public Example(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public Example(Integer id, Integer status, Date endtime,
			String starterads, String brief, Integer starterid,
			Date starttime, Integer processid, String processname,
			Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname, String datafrom) {
		this.id = id;
		this.status = status;
		this.endtime = endtime;
		this.starterads = starterads;
		this.brief = brief;
		this.starterid = starterid;
		this.starttime = starttime;
		this.processid = processid;
		this.processname = processname;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
		this.datafrom = datafrom;
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

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "ENDTIME", length = 19)
	public Date getEndtime() {
		return this.endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	@Column(name = "STARTERADS", length = 200)
	public String getStarterads() {
		return this.starterads;
	}

	public void setStarterads(String starterads) {
		this.starterads = starterads;
	}

	@Column(name = "BRIEF", length = 200)
	public String getBrief() {
		return this.brief;
	}

	public void setBrief(String brief) {
		this.brief = brief;
	}

	@Column(name = "STARTERID", precision = 65, scale = 30)
	public Integer getStarterid() {
		return this.starterid;
	}

	public void setStarterid(Integer starterid) {
		this.starterid = starterid;
	}

	@Column(name = "STARTTIME", length = 19)
	public Date getStarttime() {
		return this.starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	@Column(name = "PROCESSID", precision = 65, scale = 30)
	public Integer getProcessid() {
		return this.processid;
	}

	public void setProcessid(Integer processid) {
		this.processid = processid;
	}

	@Column(name = "PROCESSNAME", length = 100)
	public String getProcessname() {
		return this.processname;
	}

	public void setProcessname(String processname) {
		this.processname = processname;
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

	@Column(name = "DATAFROM", length = 30)
	public String getDatafrom() {
		return this.datafrom;
	}

	public void setDatafrom(String datafrom) {
		this.datafrom = datafrom;
	}

}