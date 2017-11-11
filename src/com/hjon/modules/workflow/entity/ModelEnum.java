package com.hjon.modules.workflow.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfModelenum entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_modelenum", catalog = "springmvc")
public class ModelEnum implements java.io.Serializable {

	// Fields

	private Integer objid;
	private Integer key;
	private String value;
	private String name;
	private Timestamp createtimestamp;
	private Timestamp updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ModelEnum() {
	}

	/** minimal constructor */
	public ModelEnum(Integer objid, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ModelEnum(Integer objid, Integer key, String value, String name,
			Timestamp createtimestamp, Timestamp updatetimestamp,
			Integer version, String entityname) {
		this.objid = objid;
		this.key = key;
		this.value = value;
		this.name = name;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
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

	@Column(name = "KEY", precision = 65, scale = 30)
	public Integer getKey() {
		return this.key;
	}

	public void setKey(Integer key) {
		this.key = key;
	}

	@Column(name = "VALUE", length = 20)
	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Column(name = "NAME", length = 50)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
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

}