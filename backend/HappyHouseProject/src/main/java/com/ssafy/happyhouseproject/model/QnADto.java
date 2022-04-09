package com.ssafy.happyhouseproject.model;

public class QnADto {
	private int qnaNo;
	private String userId;
	private String title;
	private String content;
	private String regTime;
	private String comment;

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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
		return "QnADto [qnaNo=" + qnaNo + ", userId=" + userId + ", title=" + title + ", content=" + content
				+ ", regTime=" + regTime + "]";
	}

}
