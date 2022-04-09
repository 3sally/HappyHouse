package com.ssafy.happyhouseproject.model;

public class UserDto extends UserInterestDto {

	private String userId;
	private String userPass;
	private String userName;
	private String userPhone;
	private String userAddr;
	private String userEmail;
	private Boolean isAdmin;

	public Boolean getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPass() {
		return userPass;
	}

	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserAddr() {
		return userAddr;
	}

	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	@Override
	public String toString() {
		return "UserDto [userId=" + userId + ", userPass=" + userPass + ", userName=" + userName + ", userPhone="
				+ userPhone + ", userAddr=" + userAddr + ", userEmail=" + userEmail + ", isAdmin=" + isAdmin
				+ ", interestArea=" + getInterestArea();
	}

}
