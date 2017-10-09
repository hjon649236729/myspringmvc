package hjon.company.modules.homepage.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "common_inform")
public class Inform {
	private String id;
	private String title;
	private String type;
	private Integer attachmentFlag;
	private String content;
	private Date createTime;
	private String createUser;

	//@GenericGenerator(name = "generator", strategy = "uuid")
	@Id
	//@GeneratedValue(generator = "generator")
	//
	@Column(name = "id", unique = true, nullable = false)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "Title", length = 500)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "attachmentFlag")
	public Integer getAttachmentFlag() {
		return attachmentFlag;
	}

	public void setAttachmentFlag(Integer attachmentFlag) {
		this.attachmentFlag = attachmentFlag;
	}

	@Column(name = "Content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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
