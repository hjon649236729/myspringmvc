package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcessjudgelinkmain entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processjudgelinkmain", catalog = "springmvc")
public class ProcessJudgeLinkMain implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer linkid;
	private String linkmain;
	private Integer status;
	private Integer sort;
	private Integer stepid;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ProcessJudgeLinkMain() {
	}

	/** minimal constructor */
	public ProcessJudgeLinkMain(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessJudgeLinkMain(Integer id, Integer linkid, String linkmain,
			Integer status, Integer sort, Integer stepid,
			Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname) {
		this.id = id;
		this.linkid = linkid;
		this.linkmain = linkmain;
		this.status = status;
		this.sort = sort;
		this.stepid = stepid;
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

	@Column(name = "LINKMAIN", length = 65535)
	public String getLinkmain() {
		return this.linkmain;
	}

	public void setLinkmain(String linkmain) {
		this.linkmain = linkmain;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "SORT", precision = 65, scale = 30)
	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@Column(name = "STEPID", precision = 65, scale = 30)
	public Integer getStepid() {
		return this.stepid;
	}

	public void setStepid(Integer stepid) {
		this.stepid = stepid;
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