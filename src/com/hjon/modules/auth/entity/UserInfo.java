package com.hjon.modules.auth.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Auth_UserInfo")
public class UserInfo {
	private Integer id;
	private String userName;
	private String passWord;
	private String empName;
	private Date createTime;
	private Date updateTime;

	// private String createUser;

	// @GenericGenerator(name = "generator", strategy = "uuid")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "UserName", length = 50)
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Column(name = "PassWord", length = 50)
	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	@Column(name = "EmpName", length = 50)
	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	@Column(name = "CreateTime", length = 50)
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name = "UpdateTime", length = 50)
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	/*
	 * @Column(name = "CreateUser", length = 50) public String getCreateUser() {
	 * return createUser; }
	 * 
	 * public void setCreateUser(String createUser) { this.createUser =
	 * createUser; }
	 */
}
