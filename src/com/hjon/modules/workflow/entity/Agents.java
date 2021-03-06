package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfAgents entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_agents", catalog = "springmvc")
public class Agents implements java.io.Serializable {

	// Fields

	private Integer id;
	private Date endtime;
	private String typesource;
	private Integer typesourceid;
	private String typeads;
	private Integer ownerid;
	private Integer agentsid;
	private Integer status;
	private Date starttime;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;
	private Integer processtype;
	private Integer processid;
	private Integer processstepid;

	// Constructors

	/** default constructor */
	public Agents() {
	}

	/** minimal constructor */
	public Agents(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public Agents(Integer id, Date endtime, String typesource,
			Integer typesourceid, String typeads, Integer ownerid,
			Integer agentsid, Integer status, Date starttime,
			Date createtimestamp, Date updatetimestamp,
			Integer version, String entityname, Integer processtype,
			Integer processid, Integer processstepid) {
		this.id = id;
		this.endtime = endtime;
		this.typesource = typesource;
		this.typesourceid = typesourceid;
		this.typeads = typeads;
		this.ownerid = ownerid;
		this.agentsid = agentsid;
		this.status = status;
		this.starttime = starttime;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
		this.processtype = processtype;
		this.processid = processid;
		this.processstepid = processstepid;
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

	@Column(name = "ENDTIME", length = 19)
	public Date getEndtime() {
		return this.endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	@Column(name = "TYPESOURCE", length = 30)
	public String getTypesource() {
		return this.typesource;
	}

	public void setTypesource(String typesource) {
		this.typesource = typesource;
	}

	@Column(name = "TYPESOURCEID", precision = 65, scale = 30)
	public Integer getTypesourceid() {
		return this.typesourceid;
	}

	public void setTypesourceid(Integer typesourceid) {
		this.typesourceid = typesourceid;
	}

	@Column(name = "TYPEADS", length = 200)
	public String getTypeads() {
		return this.typeads;
	}

	public void setTypeads(String typeads) {
		this.typeads = typeads;
	}

	@Column(name = "OWNERID", precision = 65, scale = 30)
	public Integer getOwnerid() {
		return this.ownerid;
	}

	public void setOwnerid(Integer ownerid) {
		this.ownerid = ownerid;
	}

	@Column(name = "AGENTSID", precision = 65, scale = 30)
	public Integer getAgentsid() {
		return this.agentsid;
	}

	public void setAgentsid(Integer agentsid) {
		this.agentsid = agentsid;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "STARTTIME", length = 19)
	public Date getStarttime() {
		return this.starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
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

	@Column(name = "PROCESSTYPE", precision = 65, scale = 30)
	public Integer getProcesstype() {
		return this.processtype;
	}

	public void setProcesstype(Integer processtype) {
		this.processtype = processtype;
	}

	@Column(name = "PROCESSID", precision = 65, scale = 30)
	public Integer getProcessid() {
		return this.processid;
	}

	public void setProcessid(Integer processid) {
		this.processid = processid;
	}

	@Column(name = "PROCESSSTEPID", precision = 65, scale = 30)
	public Integer getProcessstepid() {
		return this.processstepid;
	}

	public void setProcessstepid(Integer processstepid) {
		this.processstepid = processstepid;
	}

}