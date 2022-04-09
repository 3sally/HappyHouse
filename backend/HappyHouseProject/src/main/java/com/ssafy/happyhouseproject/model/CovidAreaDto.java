package com.ssafy.happyhouseproject.model;

public class CovidAreaDto {
	private int no;
	private String gugunCode;
	private String gigwanName;
	private String gigwanAddress;
	private String weekdayTime;
	private String saturdayTime;
	private String sundayTime;
	private String tel;
	private String info;
	private String lat;
	private String lng;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getGugunCode() {
		return gugunCode;
	}
	public void setGugunCode(String gugunCode) {
		this.gugunCode = gugunCode;
	}
	public String getGigwanName() {
		return gigwanName;
	}
	public void setGigwanName(String gigwanName) {
		this.gigwanName = gigwanName;
	}
	public String getGigwanAddress() {
		return gigwanAddress;
	}
	public void setGigwanAddress(String gigwanAddress) {
		this.gigwanAddress = gigwanAddress;
	}
	public String getWeekdayTime() {
		return weekdayTime;
	}
	public void setWeekdayTime(String weekdayTime) {
		this.weekdayTime = weekdayTime;
	}
	public String getSaturdayTime() {
		return saturdayTime;
	}
	public void setSaturdayTime(String saturdayTime) {
		this.saturdayTime = saturdayTime;
	}
	public String getSundayTime() {
		return sundayTime;
	}
	public void setSundayTime(String sundayTime) {
		this.sundayTime = sundayTime;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
}
