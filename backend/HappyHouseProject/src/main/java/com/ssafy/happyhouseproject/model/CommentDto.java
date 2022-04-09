package com.ssafy.happyhouseproject.model;

public class CommentDto {
	private int commentNo;
	private int qnaNo;
	private String userId;
	private String content;
	private String regTime;
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
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
		return "CommentDto [commentNo=" + commentNo + ", qnaNo=" + qnaNo + ", userId=" + userId + ", content=" + content
				+ ", regTime=" + regTime + "]";
	}
}
