package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcessurl entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processurl", catalog = "springmvc")
public class ProcessUrl implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer sort;
	private String name;
	private String actionurl;
	private String showurl;
	private Integer type;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;
	private Integer status;
	private String viewurl;

	// Constructors

	/** default constructor */
	public ProcessUrl() {
	}

	/** minimal constructor */
	public ProcessUrl(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessUrl(Integer id, Integer sort, String name,
			String actionurl, String showurl, Integer type,
			Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname, Integer status, String viewurl) {
		this.id = id;
		this.sort = sort;
		this.name = name;
		this.actionurl = actionurl;
		this.showurl = showurl;
		this.type = type;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
		this.status = status;
		this.viewurl = viewurl;
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

	@Column(name = "SORT", precision = 65, scale = 30)
	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@Column(name = "NAME", length = 100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "ACTIONURL", length = 200)
	public String getActionurl() {
		return this.actionurl;
	}

	public void setActionurl(String actionurl) {
		this.actionurl = actionurl;
	}

	@Column(name = "SHOWURL", length = 200)
	public String getShowurl() {
		return this.showurl;
	}

	public void setShowurl(String showurl) {
		this.showurl = showurl;
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

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "VIEWURL", length = 200)
	public String getViewurl() {
		return this.viewurl;
	}

	public void setViewurl(String viewurl) {
		this.viewurl = viewurl;
	}

}