package com.ssafy.happyhouseproject.model;

public class HouseInfoDto {

	private int aptCode;
	private String aptName;
	private String dongCode;
	private String dongName;
	private String roadCode;
	private String roadName;
	private int buildYear;
	private String jibun;
	private String lat;
	private String lng;
	private String img;
	private int avgDealAmount;
	public int getAvgDealAmount() {
		return avgDealAmount;
	}

	public void setAvgDealAmount(int avgDealAmount) {
		this.avgDealAmount = avgDealAmount;
	}

	public int getTotalDealCount() {
		return totalDealCount;
	}

	public void setTotalDealCount(int totalDealCount) {
		this.totalDealCount = totalDealCount;
	}

	private int totalDealCount;

	public int getAptCode() {
		return aptCode;
	}

	public void setAptCode(int aptCode) {
		this.aptCode = aptCode;
	}

	public String getAptName() {
		return aptName;
	}

	public void setAptName(String aptName) {
		this.aptName = aptName;
	}

	public String getDongCode() {
		return dongCode;
	}

	public void setDongCode(String dongCode) {
		this.dongCode = dongCode;
	}

	public String getDongName() {
		return dongName;
	}

	public void setDongName(String dongName) {
		this.dongName = dongName;
	}

	public int getBuildYear() {
		return buildYear;
	}

	public void setBuildYear(int buildYear) {
		this.buildYear = buildYear;
	}

	public String getJibun() {
		return jibun;
	}

	public void setJibun(String jibun) {
		this.jibun = jibun;
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

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getRoadCode() {
		return roadCode;
	}

	public void setRoadCode(String roadCode) {
		this.roadCode = roadCode;
	}

	public String getRoadName() {
		return roadName;
	}

	public void setRoadName(String roadName) {
		this.roadName = roadName;
	}

}
