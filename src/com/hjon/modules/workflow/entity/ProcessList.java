package com.hjon.modules.workflow.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcesslist entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processlist", catalog = "springmvc")
public class ProcessList implements java.io.Serializable {

	// Fields

	private Integer objid;
	private String value;
	private Integer status;
	private Integer sort;
	private String name;
	private Integer key;
	private Timestamp createtimestamp;
	private Timestamp updatetimestamp;
	private Integer version;
	private String entityname;
	private String valueads;
	private Integer type;

	// Constructors

	/** default constructor */
	public ProcessList() {
	}

	/** minimal constructor */
	public ProcessList(Integer objid, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessList(Integer objid, String value, Integer status,
			Integer sort, String name, Integer key, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname,
			String valueads, Integer type) {
		this.objid = objid;
		this.value = value;
		this.status = status;
		this.sort = sort;
		this.name = name;
		this.key = key;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
		this.valueads = valueads;
		this.type = type;
	}

	// Property accessors
	@Id
	@Column(name = "OBJID", unique = true, nullable = false, precision = 65, scale = 30)
	public Integer getObjid() {
		return this.objid;
	}

	public void setObjid(Integer objid) {
		this.objid = objid;
	}

	@Column(name = "VALUE", length = 200)
	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
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

	@Column(name = "NAME", length = 30)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "KEY", precision = 65, scale = 30)
	public Integer getKey() {
		return this.key;
	}

	public void setKey(Integer key) {
		this.key = key;
	}

	@Column(name = "CREATETIMESTAMP", nullable = false, length = 19)
	public Timestamp getCreatetimestamp() {
		return this.createtimestamp;
	}

	public void setCreatetimestamp(Timestamp createtimestamp) {
		this.createtimestamp = createtimestamp;
	}

	@Column(name = "UPDATETIMESTAMP", nullable = false, length = 19)
	public Timestamp getUpdatetimestamp() {
		return this.updatetimestamp;
	}

	public void setUpdatetimestamp(Timestamp updatetimestamp) {
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

	@Column(name = "VALUEADS", length = 200)
	public String getValueads() {
		return this.valueads;
	}

	public void setValueads(String valueads) {
		this.valueads = valueads;
	}

	@Column(name = "TYPE", precision = 65, scale = 30)
	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

}