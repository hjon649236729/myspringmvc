package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfModeloneurl entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_modeloneurl", catalog = "springmvc")
public class ModelOneUrl implements java.io.Serializable {

	// Fields

	private Integer id;
	private String approveurl;
	private String editurl;
	private String watchurl;
	private Integer status;
	private Integer typeid;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ModelOneUrl() {
	}

	/** minimal constructor */
	public ModelOneUrl(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ModelOneUrl(Integer id, String approveurl, String editurl,
			String watchurl, Integer status, Integer typeid,
			Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname) {
		this.id = id;
		this.approveurl = approveurl;
		this.editurl = editurl;
		this.watchurl = watchurl;
		this.status = status;
		this.typeid = typeid;
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

	@Column(name = "APPROVEURL", length = 200)
	public String getApproveurl() {
		return this.approveurl;
	}

	public void setApproveurl(String approveurl) {
		this.approveurl = approveurl;
	}

	@Column(name = "EDITURL", length = 200)
	public String getEditurl() {
		return this.editurl;
	}

	public void setEditurl(String editurl) {
		this.editurl = editurl;
	}

	@Column(name = "WATCHURL", length = 200)
	public String getWatchurl() {
		return this.watchurl;
	}

	public void setWatchurl(String watchurl) {
		this.watchurl = watchurl;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "TYPEID", precision = 65, scale = 30)
	public Integer getTypeid() {
		return this.typeid;
	}

	public void setTypeid(Integer typeid) {
		this.typeid = typeid;
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