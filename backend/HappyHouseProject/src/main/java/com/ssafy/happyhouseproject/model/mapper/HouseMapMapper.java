package com.ssafy.happyhouseproject.model.mapper;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouseproject.model.BaseAddressDto;
import com.ssafy.happyhouseproject.model.CovidAreaDto;
import com.ssafy.happyhouseproject.model.HouseDealDto;
import com.ssafy.happyhouseproject.model.HouseInfoDto;
import com.ssafy.happyhouseproject.model.SidoGugunCodeDto;

public interface HouseMapMapper {
	List<SidoGugunCodeDto> getSido() throws SQLException;

	List<SidoGugunCodeDto> getGugunInSido(String sido) throws SQLException;

	List<HouseInfoDto> getDongInGugun(String gugun) throws SQLException;

	List<HouseInfoDto> getAptInDong(String dong) throws SQLException;

	List<HouseDealDto> getHouseDeal(String aptCode) throws SQLException;
	
	BaseAddressDto getBaseAddress(String sidoName, String gugunName, String dongName) throws SQLException;

	List<CovidAreaDto> getCovid() throws Exception;
}