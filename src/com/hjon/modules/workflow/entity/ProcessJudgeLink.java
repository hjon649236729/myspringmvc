package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcessjudgelink entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processjudgelink", catalog = "springmvc")
public class ProcessJudgeLink implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer stepid;
	private Integer result;
	private String resultads;
	private Integer status;
	private Integer type;
	private Integer sort;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ProcessJudgeLink() {
	}

	/** minimal constructor */
	public ProcessJudgeLink(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessJudgeLink(Integer id, Integer stepid, Integer result,
			String resultads, Integer status, Integer type, Integer sort,
			Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname) {
		this.id = id;
		this.stepid = stepid;
		this.result = result;
		this.resultads = resultads;
		this.status = status;
		this.type = type;
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

	@Column(name = "STEPID", precision = 65, scale = 30)
	public Integer getStepid() {
		return this.stepid;
	}

	public void setStepid(Integer stepid) {
		this.stepid = stepid;
	}

	@Column(name = "RESULT", precision = 65, scale = 30)
	public Integer getResult() {
		return this.result;
	}

	public void setResult(Integer result) {
		this.result = result;
	}

	@Column(name = "RESULTADS", length = 65535)
	public String getResultads() {
		return this.resultads;
	}

	public void setResultads(String resultads) {
		this.resultads = resultads;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "TYPE", precision = 65, scale = 30)
	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
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