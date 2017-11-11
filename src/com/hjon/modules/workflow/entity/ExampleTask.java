package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfExampletask entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_exampletask", catalog = "springmvc")
public class ExampleTask implements java.io.Serializable {

	// Fields

	private Integer id;
	private String sourceentity;
	private Integer sourceid;
	private Integer dealerid;
	private Integer orginerid;
	private Integer status;
	private Date starttime;
	private Date endtime;
	private String description;
	private String remarks;
	private Integer sort;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ExampleTask() {
	}

	/** minimal constructor */
	public ExampleTask(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ExampleTask(Integer id, String sourceentity, Integer sourceid,
			Integer dealerid, Integer orginerid, Integer status,
			Date starttime, Date endtime, String description,
			String remarks, Integer sort, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.sourceentity = sourceentity;
		this.sourceid = sourceid;
		this.dealerid = dealerid;
		this.orginerid = orginerid;
		this.status = status;
		this.starttime = starttime;
		this.endtime = endtime;
		this.description = description;
		this.remarks = remarks;
		this.sort = sort;
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

	@Column(name = "SOURCEENTITY", length = 30)
	public String getSourceentity() {
		return this.sourceentity;
	}

	public void setSourceentity(String sourceentity) {
		this.sourceentity = sourceentity;
	}

	@Column(name = "SOURCEID", precision = 65, scale = 30)
	public Integer getSourceid() {
		return this.sourceid;
	}

	public void setSourceid(Integer sourceid) {
		this.sourceid = sourceid;
	}

	@Column(name = "DEALERID", precision = 65, scale = 30)
	public Integer getDealerid() {
		return this.dealerid;
	}

	public void setDealerid(Integer dealerid) {
		this.dealerid = dealerid;
	}

	@Column(name = "ORGINERID", precision = 65, scale = 30)
	public Integer getOrginerid() {
		return this.orginerid;
	}

	public void setOrginerid(Integer orginerid) {
		this.orginerid = orginerid;
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

	@Column(name = "ENDTIME", length = 19)
	public Date getEndtime() {
		return this.endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	@Column(name = "DESCRIPTION", length = 200)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "REMARKS", length = 100)
	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	@Column(name = "SORT", precision = 65, scale = 30)
	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
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