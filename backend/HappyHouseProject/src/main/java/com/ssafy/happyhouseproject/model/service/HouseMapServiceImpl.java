package com.ssafy.happyhouseproject.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouseproject.model.BaseAddressDto;
import com.ssafy.happyhouseproject.model.CovidAreaDto;
import com.ssafy.happyhouseproject.model.HouseDealDto;
import com.ssafy.happyhouseproject.model.HouseInfoDto;
import com.ssafy.happyhouseproject.model.SidoGugunCodeDto;
import com.ssafy.happyhouseproject.model.mapper.HouseMapMapper;

@Service
public class HouseMapServiceImpl implements HouseMapService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getGugunInSido(sido);
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getDongInGugun(gugun);
	}

	@Override
	public List<HouseInfoDto> getAptInDong(String dong) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getAptInDong(dong);
	}

	@Override
	public List<HouseDealDto> getHouseDeal(String aptCode) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getHouseDeal(aptCode);
	}

	@Override
	public BaseAddressDto getBaseAddress(String sidoName, String gugunName, String dongName) throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getBaseAddress(sidoName, gugunName, dongName);
	}

	@Override
	public List<CovidAreaDto> getCovid() throws Exception {
		return sqlSession.getMapper(HouseMapMapper.class).getCovid();
	}

}