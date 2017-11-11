package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcesssteplinkdo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processsteplinkdo", catalog = "springmvc")
public class ProcessStepLinkDo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer linkid;
	private Integer processid;
	private Integer dotype;
	private String doads;
	private Integer domark;
	private Integer stepid;
	private Integer status;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ProcessStepLinkDo() {
	}

	/** minimal constructor */
	public ProcessStepLinkDo(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessStepLinkDo(Integer id, Integer linkid, Integer processid,
			Integer dotype, String doads, Integer domark, Integer stepid,
			Integer status, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.linkid = linkid;
		this.processid = processid;
		this.dotype = dotype;
		this.doads = doads;
		this.domark = domark;
		this.stepid = stepid;
		this.status = status;
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

	@Column(name = "LINKID", precision = 65, scale = 30)
	public Integer getLinkid() {
		return this.linkid;
	}

	public void setLinkid(Integer linkid) {
		this.linkid = linkid;
	}

	@Column(name = "PROCESSID", precision = 65, scale = 30)
	public Integer getProcessid() {
		return this.processid;
	}

	public void setProcessid(Integer processid) {
		this.processid = processid;
	}

	@Column(name = "DOTYPE", precision = 65, scale = 30)
	public Integer getDotype() {
		return this.dotype;
	}

	public void setDotype(Integer dotype) {
		this.dotype = dotype;
	}

	@Column(name = "DOADS", length = 200)
	public String getDoads() {
		return this.doads;
	}

	public void setDoads(String doads) {
		this.doads = doads;
	}

	@Column(name = "DOMARK", precision = 65, scale = 30)
	public Integer getDomark() {
		return this.domark;
	}

	public void setDomark(Integer domark) {
		this.domark = domark;
	}

	@Column(name = "STEPID", precision = 65, scale = 30)
	public Integer getStepid() {
		return this.stepid;
	}

	public void setStepid(Integer stepid) {
		this.stepid = stepid;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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