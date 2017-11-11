package com.hjon.modules.workflow.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcess entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_process", catalog = "springmvc")
public class Process implements java.io.Serializable {

	// Fields

	private Integer objid;
	private Integer status;
	private String name;
	private Integer sort;
	private Integer processversion;
	private String processcode;
	private Timestamp createtimestamp;
	private Timestamp updatetimestamp;
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
	public Process() {
	}

	/** minimal constructor */
	public Process(Integer objid, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public Process(Integer objid, Integer status, String name, Integer sort,
			Integer processversion, String processcode,
			Timestamp createtimestamp, Timestamp updatetimestamp,
			Integer version, String entityname, String syscode,
			Integer sysversion, Integer processtype, String processbrief,
			String specialmark, Integer phoneshow, Integer claimtype) {
		this.objid = objid;
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
	@Column(name = "OBJID", unique = true, nullable = false, precision = 65, scale = 30)
	public Integer getObjid() {
		return this.objid;
	}

	public void setObjid(Integer objid) {
		this.objid = objid;
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