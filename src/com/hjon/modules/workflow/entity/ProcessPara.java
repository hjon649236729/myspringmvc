package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcesspara entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processpara", catalog = "springmvc")
public class ProcessPara implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer typeid;
	private String codename;
	private String showname;
	private Integer sort;
	private Integer kind;
	private String basevalue;
	private Integer columnid;
	private Integer status;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ProcessPara() {
	}

	/** minimal constructor */
	public ProcessPara(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessPara(Integer id, Integer typeid, String codename,
			String showname, Integer sort, Integer kind, String basevalue,
			Integer columnid, Integer status, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.typeid = typeid;
		this.codename = codename;
		this.showname = showname;
		this.sort = sort;
		this.kind = kind;
		this.basevalue = basevalue;
		this.columnid = columnid;
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

	@Column(name = "TYPEID", precision = 65, scale = 30)
	public Integer getTypeid() {
		return this.typeid;
	}

	public void setTypeid(Integer typeid) {
		this.typeid = typeid;
	}

	@Column(name = "CODENAME", length = 30)
	public String getCodename() {
		return this.codename;
	}

	public void setCodename(String codename) {
		this.codename = codename;
	}

	@Column(name = "SHOWNAME", length = 30)
	public String getShowname() {
		return this.showname;
	}

	public void setShowname(String showname) {
		this.showname = showname;
	}

	@Column(name = "SORT", precision = 65, scale = 30)
	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@Column(name = "KIND", precision = 65, scale = 30)
	public Integer getKind() {
		return this.kind;
	}

	public void setKind(Integer kind) {
		this.kind = kind;
	}

	@Column(name = "BASEVALUE", length = 200)
	public String getBasevalue() {
		return this.basevalue;
	}

	public void setBasevalue(String basevalue) {
		this.basevalue = basevalue;
	}

	@Column(name = "COLUMNID", precision = 65, scale = 30)
	public Integer getColumnid() {
		return this.columnid;
	}

	public void setColumnid(Integer columnid) {
		this.columnid = columnid;
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