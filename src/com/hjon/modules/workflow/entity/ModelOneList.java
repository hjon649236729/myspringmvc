package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfModelonelist entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_modelonelist", catalog = "springmvc")
public class ModelOneList implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer sort;
	private String name;
	private String rules;
	private String executor;
	private String taskremind;
	private Integer processid;
	private Integer status;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ModelOneList() {
	}

	/** minimal constructor */
	public ModelOneList(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ModelOneList(Integer id, Integer sort, String name, String rules,
			String executor, String taskremind, Integer processid,
			Integer status, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.sort = sort;
		this.name = name;
		this.rules = rules;
		this.executor = executor;
		this.taskremind = taskremind;
		this.processid = processid;
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

	@Column(name = "SORT", precision = 65, scale = 30)
	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@Column(name = "NAME", length = 50)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "RULES", length = 50)
	public String getRules() {
		return this.rules;
	}

	public void setRules(String rules) {
		this.rules = rules;
	}

	@Column(name = "EXECUTOR", length = 65535)
	public String getExecutor() {
		return this.executor;
	}

	public void setExecutor(String executor) {
		this.executor = executor;
	}

	@Column(name = "TASKREMIND", length = 65535)
	public String getTaskremind() {
		return this.taskremind;
	}

	public void setTaskremind(String taskremind) {
		this.taskremind = taskremind;
	}

	@Column(name = "PROCESSID", precision = 65, scale = 30)
	public Integer getProcessid() {
		return this.processid;
	}

	public void setProcessid(Integer processid) {
		this.processid = processid;
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