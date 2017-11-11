package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfExampleentry entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_exampleentry", catalog = "springmvc")
public class ExampleEntry implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer status;
	private String sourcename;
	private Integer sourceid;
	private Date changetime;
	private Integer exampleid;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ExampleEntry() {
	}

	/** minimal constructor */
	public ExampleEntry(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ExampleEntry(Integer id, Integer status, String sourcename,
			Integer sourceid, Date changetime, Integer exampleid,
			Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname) {
		this.id = id;
		this.status = status;
		this.sourcename = sourcename;
		this.sourceid = sourceid;
		this.changetime = changetime;
		this.exampleid = exampleid;
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

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "SOURCENAME", length = 30)
	public String getSourcename() {
		return this.sourcename;
	}

	public void setSourcename(String sourcename) {
		this.sourcename = sourcename;
	}

	@Column(name = "SOURCEID", precision = 65, scale = 30)
	public Integer getSourceid() {
		return this.sourceid;
	}

	public void setSourceid(Integer sourceid) {
		this.sourceid = sourceid;
	}

	@Column(name = "CHANGETIME", length = 19)
	public Date getChangetime() {
		return this.changetime;
	}

	public void setChangetime(Date changetime) {
		this.changetime = changetime;
	}

	@Column(name = "EXAMPLEID", precision = 65, scale = 30)
	public Integer getExampleid() {
		return this.exampleid;
	}

	public void setExampleid(Integer exampleid) {
		this.exampleid = exampleid;
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