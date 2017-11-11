package com.hjon.modules.workflow.entity;

import java.util.Date;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcess entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processinfo", catalog = "springmvc")
public class ProcessInfo implements java.io.Serializable {
	public static String ENTITY_NAME = "ProcessInfo";
	// Fields

	private Integer id;
	private Integer status;
	private String name;
	private Integer sort;
	private Integer processversion;
	private String processcode;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;
	private String syscode;
	private Integer sysversion;
	private Integer processtype;
	private String processbrief;
	private String specialmark;
	private Integer phoneshow;
	private Integer claimtype;

	// Constructors

	/** default constructor */
	public ProcessInfo() {
		this.createtimestamp = new Date();
		this.updatetimestamp = new Date();
	}

	/** minimal constructor */
	public ProcessInfo(Integer id, Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessInfo(Integer id, Integer status, String name, Integer sort,
			Integer processversion, String processcode, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname,
			String syscode, Integer sysversion, Integer processtype,
			String processbrief, String specialmark, Integer phoneshow,
			Integer claimtype) {
		this.id = id;
		this.status = status;
		this.name = name;
		this.sort = sort;
		this.processversion = processversion;
		this.processcode = processcode;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
		this.syscode = syscode;
		this.sysversion = sysversion;
		this.processtype = processtype;
		this.processbrief = processbrief;
		this.specialmark = specialmark;
		this.phoneshow = phoneshow;
		this.claimtype = claimtype;
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

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "NAME", length = 100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "SORT", precision = 65, scale = 30)
	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@Column(name = "PROCESSVERSION", precision = 65, scale = 30)
	public Integer getProcessversion() {
		return this.processversion;
	}

	public void setProcessversion(Integer processversion) {
		this.processversion = processversion;
	}

	@Column(name = "PROCESSCODE", length = 30)
	public String getProcesscode() {
		return this.processcode;
	}

	public void setProcesscode(String processcode) {
		this.processcode = processcode;
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

	@Column(name = "SYSCODE", length = 30)
	public String getSyscode() {
		return this.syscode;
	}

	public void setSyscode(String syscode) {
		this.syscode = syscode;
	}

	@Column(name = "SYSVERSION", precision = 65, scale = 30)
	public Integer getSysversion() {
		return this.sysversion;
	}

	public void setSysversion(Integer sysversion) {
		this.sysversion = sysversion;
	}

	@Column(name = "PROCESSTYPE", precision = 65, scale = 30)
	public Integer getProcesstype() {
		return this.processtype;
	}

	public void setProcesstype(Integer processtype) {
		this.processtype = processtype;
	}

	@Column(name = "PROCESSBRIEF", length = 200)
	public String getProcessbrief() {
		return this.processbrief;
	}

	public void setProcessbrief(String processbrief) {
		this.processbrief = processbrief;
	}

	@Column(name = "SPECIALMARK", length = 200)
	public String getSpecialmark() {
		return this.specialmark;
	}

	public void setSpecialmark(String specialmark) {
		this.specialmark = specialmark;
	}

	@Column(name = "PHONESHOW", precision = 65, scale = 30)
	public Integer getPhoneshow() {
		return this.phoneshow;
	}

	public void setPhoneshow(Integer phoneshow) {
		this.phoneshow = phoneshow;
	}

	@Column(name = "CLAIMTYPE", precision = 65, scale = 30)
	public Integer getClaimtype() {
		return this.claimtype;
	}

	public void setClaimtype(Integer claimtype) {
		this.claimtype = claimtype;
	}

}