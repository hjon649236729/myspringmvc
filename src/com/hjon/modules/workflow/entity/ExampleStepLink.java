package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfExamplesteplink entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_examplesteplink", catalog = "springmvc")
public class ExampleStepLink implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer prestepid;
	private Integer aftstepid;
	private Integer status;
	private Integer exampleid;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ExampleStepLink() {
	}

	/** minimal constructor */
	public ExampleStepLink(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ExampleStepLink(Integer id, Integer prestepid, Integer aftstepid,
			Integer status, Integer exampleid, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.prestepid = prestepid;
		this.aftstepid = aftstepid;
		this.status = status;
		this.exampleid = exampleid;
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

	@Column(name = "PRESTEPID", precision = 65, scale = 30)
	public Integer getPrestepid() {
		return this.prestepid;
	}

	public void setPrestepid(Integer prestepid) {
		this.prestepid = prestepid;
	}

	@Column(name = "AFTSTEPID", precision = 65, scale = 30)
	public Integer getAftstepid() {
		return this.aftstepid;
	}

	public void setAftstepid(Integer aftstepid) {
		this.aftstepid = aftstepid;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "EXAMPLEID", precision = 65, scale = 30)
	public Integer getExampleid() {
		return this.exampleid;
	}

	public void setExampleid(Integer exampleid) {
		this.exampleid = exampleid;
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