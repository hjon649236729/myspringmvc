package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfExamplepara entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_examplepara", catalog = "springmvc")
public class ExamplePara implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer type;
	private String name;
	private String value;
	private Integer exampleid;
	private Integer examplestepid;
	private Integer exampleownerid;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ExamplePara() {
	}

	/** minimal constructor */
	public ExamplePara(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ExamplePara(Integer id, Integer type, String name, String value,
			Integer exampleid, Integer examplestepid, Integer exampleownerid,
			Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname) {
		this.id = id;
		this.type = type;
		this.name = name;
		this.value = value;
		this.exampleid = exampleid;
		this.examplestepid = examplestepid;
		this.exampleownerid = exampleownerid;
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

	@Column(name = "TYPE", precision = 65, scale = 30)
	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	@Column(name = "NAME", length = 30)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "VALUE", length = 65535)
	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Column(name = "EXAMPLEID", precision = 65, scale = 30)
	public Integer getExampleid() {
		return this.exampleid;
	}

	public void setExampleid(Integer exampleid) {
		this.exampleid = exampleid;
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