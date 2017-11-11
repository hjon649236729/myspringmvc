package com.hjon.modules.workflow.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfProcessmail entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_processmail", catalog = "springmvc")
public class ProcessMail implements java.io.Serializable {

	// Fields

	private Integer objid;
	private String mailcontext;
	private Integer mailgoto;
	private Integer mailgotoid;
	private Integer processid;
	private Integer stepid;
	private String mailtitle;
	private Integer status;
	private Timestamp createtimestamp;
	private Timestamp updatetimestamp;
	private Integer version;
	private String entityname;

	// Constructors

	/** default constructor */
	public ProcessMail() {
	}

	/** minimal constructor */
	public ProcessMail(Integer objid, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ProcessMail(Integer objid, String mailcontext, Integer mailgoto,
			Integer mailgotoid, Integer processid, Integer stepid,
			String mailtitle, Integer status, Timestamp createtimestamp,
			Timestamp updatetimestamp, Integer version, String entityname) {
		this.objid = objid;
		this.mailcontext = mailcontext;
		this.mailgoto = mailgoto;
		this.mailgotoid = mailgotoid;
		this.processid = processid;
		this.stepid = stepid;
		this.mailtitle = mailtitle;
		this.status = status;
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

	@Column(name = "MAILCONTEXT", length = 65535)
	public String getMailcontext() {
		return this.mailcontext;
	}

	public void setMailcontext(String mailcontext) {
		this.mailcontext = mailcontext;
	}

	@Column(name = "MAILGOTO", precision = 65, scale = 30)
	public Integer getMailgoto() {
		return this.mailgoto;
	}

	public void setMailgoto(Integer mailgoto) {
		this.mailgoto = mailgoto;
	}

	@Column(name = "MAILGOTOID", precision = 65, scale = 30)
	public Integer getMailgotoid() {
		return this.mailgotoid;
	}

	public void setMailgotoid(Integer mailgotoid) {
		this.mailgotoid = mailgotoid;
	}

	@Column(name = "PROCESSID", precision = 65, scale = 30)
	public Integer getProcessid() {
		return this.processid;
	}

	public void setProcessid(Integer processid) {
		this.processid = processid;
	}

	@Column(name = "STEPID", precision = 65, scale = 30)
	public Integer getStepid() {
		return this.stepid;
	}

	public void setStepid(Integer stepid) {
		this.stepid = stepid;
	}

	@Column(name = "MAILTITLE", length = 200)
	public String getMailtitle() {
		return this.mailtitle;
	}

	public void setMailtitle(String mailtitle) {
		this.mailtitle = mailtitle;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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