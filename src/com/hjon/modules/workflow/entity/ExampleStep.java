package com.hjon.modules.workflow.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * WfExamplestep entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "wf_examplestep", catalog = "springmvc")
public class ExampleStep implements java.io.Serializable {

	// Fields

	private Integer id;
	private Date endtime;
	private Integer processstepid;
	private Integer processid;
	private Integer exampleid;
	private Integer status;
	private String processstepname;
	private String brief;
	private String stepbeigin;
	private String stepend;
	private Integer stepcondition;
	private Integer steptype;
	private String actionurl;
	private String showurl;
	private Integer urlmark;
	private Date starttime;
	private Date createtimestamp;
	private Date updatetimestamp;
	private Integer version;
	private String entityname;
	private Integer branchstepid;
	private Integer recoverflag;

	// Constructors

	/** default constructor */
	public ExampleStep() {
	}

	/** minimal constructor */
	public ExampleStep(Integer id, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname) {
		this.id = id;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
	}

	/** full constructor */
	public ExampleStep(Integer id, Date endtime, Integer processstepid,
			Integer processid, Integer exampleid, Integer status,
			String processstepname, String brief, String stepbeigin,
			String stepend, Integer stepcondition, Integer steptype,
			String actionurl, String showurl, Integer urlmark,
			Date starttime, Date createtimestamp,
			Date updatetimestamp, Integer version, String entityname,
			Integer branchstepid, Integer recoverflag) {
		this.id = id;
		this.endtime = endtime;
		this.processstepid = processstepid;
		this.processid = processid;
		this.exampleid = exampleid;
		this.status = status;
		this.processstepname = processstepname;
		this.brief = brief;
		this.stepbeigin = stepbeigin;
		this.stepend = stepend;
		this.stepcondition = stepcondition;
		this.steptype = steptype;
		this.actionurl = actionurl;
		this.showurl = showurl;
		this.urlmark = urlmark;
		this.starttime = starttime;
		this.createtimestamp = createtimestamp;
		this.updatetimestamp = updatetimestamp;
		this.version = version;
		this.entityname = entityname;
		this.branchstepid = branchstepid;
		this.recoverflag = recoverflag;
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

	@Column(name = "PROCESSSTEPID", precision = 65, scale = 30)
	public Integer getProcessstepid() {
		return this.processstepid;
	}

	public void setProcessstepid(Integer processstepid) {
		this.processstepid = processstepid;
	}

	@Column(name = "PROCESSID", precision = 65, scale = 30)
	public Integer getProcessid() {
		return this.processid;
	}

	public void setProcessid(Integer processid) {
		this.processid = processid;
	}

	@Column(name = "EXAMPLEID", precision = 65, scale = 30)
	public Integer getExampleid() {
		return this.exampleid;
	}

	public void setExampleid(Integer exampleid) {
		this.exampleid = exampleid;
	}

	@Column(name = "STATUS", precision = 65, scale = 30)
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "PROCESSSTEPNAME", length = 100)
	public String getProcessstepname() {
		return this.processstepname;
	}

	public void setProcessstepname(String processstepname) {
		this.processstepname = processstepname;
	}

	@Column(name = "BRIEF", length = 200)
	public String getBrief() {
		return this.brief;
	}

	public void setBrief(String brief) {
		this.brief = brief;
	}

	@Column(name = "STEPBEIGIN", length = 65535)
	public String getStepbeigin() {
		return this.stepbeigin;
	}

	public void setStepbeigin(String stepbeigin) {
		this.stepbeigin = stepbeigin;
	}

	@Column(name = "STEPEND", length = 65535)
	public String getStepend() {
		return this.stepend;
	}

	public void setStepend(String stepend) {
		this.stepend = stepend;
	}

	@Column(name = "STEPCONDITION", precision = 65, scale = 30)
	public Integer getStepcondition() {
		return this.stepcondition;
	}

	public void setStepcondition(Integer stepcondition) {
		this.stepcondition = stepcondition;
	}

	@Column(name = "STEPTYPE", precision = 65, scale = 30)
	public Integer getSteptype() {
		return this.steptype;
	}

	public void setSteptype(Integer steptype) {
		this.steptype = steptype;
	}

	@Column(name = "ACTIONURL", length = 200)
	public String getActionurl() {
		return this.actionurl;
	}

	public void setActionurl(String actionurl) {
		this.actionurl = actionurl;
	}

	@Column(name = "SHOWURL", length = 200)
	public String getShowurl() {
		return this.showurl;
	}

	public void setShowurl(String showurl) {
		this.showurl = showurl;
	}

	@Column(name = "URLMARK", precision = 65, scale = 30)
	public Integer getUrlmark() {
		return this.urlmark;
	}

	public void setUrlmark(Integer urlmark) {
		this.urlmark = urlmark;
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

	@Column(name = "BRANCHSTEPID", precision = 65, scale = 30)
	public Integer getBranchstepid() {
		return this.branchstepid;
	}

	public void setBranchstepid(Integer branchstepid) {
		this.branchstepid = branchstepid;
	}

	@Column(name = "RECOVERFLAG", precision = 65, scale = 30)
	public Integer getRecoverflag() {
		return this.recoverflag;
	}

	public void setRecoverflag(Integer recoverflag) {
		this.recoverflag = recoverflag;
	}

}