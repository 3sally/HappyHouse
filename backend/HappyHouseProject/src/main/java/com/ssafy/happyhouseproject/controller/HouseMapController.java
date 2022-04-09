package com.ssafy.happyhouseproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouseproject.model.BaseAddressDto;
import com.ssafy.happyhouseproject.model.CovidAreaDto;
import com.ssafy.happyhouseproject.model.HouseDealDto;
import com.ssafy.happyhouseproject.model.HouseInfoDto;
import com.ssafy.happyhouseproject.model.SidoGugunCodeDto;
import com.ssafy.happyhouseproject.model.service.HouseMapService;

@RestController
@RequestMapping("/map")
public class HouseMapController {
	
	@Autowired
	private HouseMapService houseMapService;
	
	@GetMapping("/sido")
	public ResponseEntity<List<SidoGugunCodeDto>> sido() throws Exception {
		return new ResponseEntity<List<SidoGugunCodeDto>>(houseMapService.getSido(), HttpStatus.OK);
	}
	
	@GetMapping("/gugun")
	public ResponseEntity<List<SidoGugunCodeDto>> gugun(@RequestParam("sido") String sido) throws Exception {
		return new ResponseEntity<List<SidoGugunCodeDto>>(houseMapService.getGugunInSido(sido), HttpStatus.OK);
	}
	
	@GetMapping("/dong")
	public ResponseEntity<List<HouseInfoDto>> dong(@RequestParam("gugun") String gugun) throws Exception {
		return new ResponseEntity<List<HouseInfoDto>>(houseMapService.getDongInGugun(gugun), HttpStatus.OK);
	}
	
	@GetMapping("/apt")
	public ResponseEntity<List<HouseInfoDto>> apt(@RequestParam("dong") String dong) throws Exception {
		return new ResponseEntity<List<HouseInfoDto>>(houseMapService.getAptInDong(dong), HttpStatus.OK);
	}

	@GetMapping("/deal")
	public ResponseEntity<List<HouseDealDto>> deal(@RequestParam("aptCode") String aptCode) throws Exception {
		return new ResponseEntity<List<HouseDealDto>>(houseMapService.getHouseDeal(aptCode), HttpStatus.OK);
	}
	
	@GetMapping("/base")
	public ResponseEntity<BaseAddressDto> base(@RequestParam("sidoName") String sidoName, @RequestParam("gugunName") String gugunName, @RequestParam("dongName") String dongName) throws Exception {
		return new ResponseEntity<BaseAddressDto>(houseMapService.getBaseAddress(sidoName, gugunName, dongName), HttpStatus.OK);
	}
	
	@GetMapping("/covid")
	public ResponseEntity<List<CovidAreaDto>> covid() throws Exception {
		return new ResponseEntity<List<CovidAreaDto>>(houseMapService.getCovid(), HttpStatus.OK);
	}
}