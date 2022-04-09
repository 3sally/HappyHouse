package com.ssafy.happyhouseproject.model;

public class NoticeDto {
	private int articleNo;
	private String userId;
	private String userName;
	private String subject;
	private String content;
	private String regTime;
	private int views;

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getArticleNo() {
		return articleNo;
	}

	public void setArticleNo(int articleNo) {
		this.articleNo = articleNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegTime() {
		return regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	@Override
	public String toString() {
		return "NoticeDto [articleNo=" + articleNo + ", userId=" + userId + ", userName=" + userName + ", subject="
				+ subject + ", content=" + content + ", regTime=" + regTime + "]";
	}

}
