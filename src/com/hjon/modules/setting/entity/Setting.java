package com.hjon.modules.setting.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "common_setting")
public class Setting {
	private Integer id;
	private String module;
	private String name;
	private String value;
	private String remark;
	private Date createTime;
	private String createUser;

	// @GenericGenerator(name = "generator", strategy = "uuid")
	@Id
	// @GeneratedValue(generator = "generator")
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "Module", length = 50)
	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	@Column(name = "Name", length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "Value", length = 500)
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	@Column(name = "Remark", length = 1000)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "CreateTime", length = 50)
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name = "CreateUser", length = 50)
	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

}
