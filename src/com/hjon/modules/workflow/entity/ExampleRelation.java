package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfExamplerelation entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_examplerelation", catalog = "springmvc")
public class ExampleRelation implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer examplestepid;
	private Integer exampleownerid;
	private Integer subexampleid;
	private Integer status;
	private Integer mark;
	private String brief;
	private Integer exampleid;
	private Integer sort;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ExampleRelation() {
	}

	/** minimal constructor */
	public ExampleRelation(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ExampleRelation(Integer id, Integer examplestepid,
			Integer exampleownerid, Integer subexampleid, Integer status,
			Integer mark, String brief, Integer exampleid, Integer sort,
			Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname) {
		this.id = id;
		this.examplestepid = examplestepid;
		this.exampleownerid = exampleownerid;
		this.subexampleid = subexampleid;
		this.status = status;
		this.mark = mark;
		this.brief = brief;
		this.exampleid = exampleid;
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

	@Column(name = "EXAMPLESTEPID", precision = 65, scale = 30)
	public Integer getExamplestepid() {
		return this.examplestepid;
	}

	public void setExamplestepid(Integer examplestepid) {
		this.examplestepid = examplestepid;
	}

	@Column(name = "EXAMPLEOWNERID", precision = 65, scale = 30)
	public Integer getExampleownerid() {
		return this.exampleownerid;
	}

	public void setExampleownerid(Integer exampleownerid) {
		this.exampleownerid = exampleownerid;
	}

	@Column(name = "SUBEXAMPLEID", precision = 65, scale = 30)
	public Integer getSubexampleid() {
		return this.subexampleid;
	}

	public void setSubexampleid(Integer subexampleid) {
		this.subexampleid = subexampleid;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "MARK", precision = 65, scale = 30)
	public Integer getMark() {
		return this.mark;
	}

	public void setMark(Integer mark) {
		this.mark = mark;
	}

	@Column(name = "BRIEF", length = 65535)
	public String getBrief() {
		return this.brief;
	}

	public void setBrief(String brief) {
		this.brief = brief;
	}

	@Column(name = "EXAMPLEID", precision = 65, scale = 30)
	public Integer getExampleid() {
		return this.exampleid;
	}

	public void setExampleid(Integer exampleid) {
		this.exampleid = exampleid;
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