package com.ssafy.happyhouseproject.model;

public class UserInterestDto {
	private String userId;
	private String interestArea;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getInterestArea() {
		return interestArea;
	}

	public void setInterestArea(String interestArea) {
		this.interestArea = interestArea;
	}

	@Override
	public String toString() {
		return "UserInterestDto [userId=" + userId + ", interestArea=" + interestArea + "]";
	}

}
