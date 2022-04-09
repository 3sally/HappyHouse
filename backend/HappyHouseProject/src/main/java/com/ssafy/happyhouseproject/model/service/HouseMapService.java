package com.ssafy.happyhouseproject.model.service;

import java.util.List;

import com.ssafy.happyhouseproject.model.BaseAddressDto;
import com.ssafy.happyhouseproject.model.CovidAreaDto;
import com.ssafy.happyhouseproject.model.HouseDealDto;
import com.ssafy.happyhouseproject.model.HouseInfoDto;
import com.ssafy.happyhouseproject.model.SidoGugunCodeDto;

public interface HouseMapService {
	 
	List<SidoGugunCodeDto> getSido() throws Exception;
	List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception;
	List<HouseInfoDto> getDongInGugun(String gugun) throws Exception;
	List<HouseInfoDto> getAptInDong(String dong) throws Exception;
	List<HouseDealDto> getHouseDeal(String aptCode) throws Exception;
	BaseAddressDto getBaseAddress(String sidoName, String gugunName, String dongName) throws Exception;
	List<CovidAreaDto> getCovid() throws Exception;
}