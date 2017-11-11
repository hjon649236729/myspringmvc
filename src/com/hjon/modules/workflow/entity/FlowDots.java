package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfFlowdots entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_flowdots", catalog = "springmvc")
public class FlowDots implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer sort;
	private Integer pathid;
	private String pos;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public FlowDots() {
	}

	/** minimal constructor */
	public FlowDots(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public FlowDots(Integer id, Integer sort, Integer pathid, String pos,
			Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname) {
		this.id = id;
		this.sort = sort;
		this.pathid = pathid;
		this.pos = pos;
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

	@Column(name = "PATHID", precision = 65, scale = 30)
	public Integer getPathid() {
		return this.pathid;
	}

	public void setPathid(Integer pathid) {
		this.pathid = pathid;
	}

	@Column(name = "POS", length = 100)
	public String getPos() {
		return this.pos;
	}

	public void setPos(String pos) {
		this.pos = pos;
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