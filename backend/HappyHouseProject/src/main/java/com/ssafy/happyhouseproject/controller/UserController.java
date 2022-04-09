package com.ssafy.happyhouseproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouseproject.model.UserDto;
import com.ssafy.happyhouseproject.model.service.JwtServiceImpl;
import com.ssafy.happyhouseproject.model.service.UserService;

import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("/user")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@Autowired
	private JwtServiceImpl jwtService;

	@Autowired
	private UserService userService;

	@PostMapping("/login")
	public ResponseEntity<Map<String, Object>> login(@RequestBody UserDto userDto) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		try {
			UserDto loginUser = userService.login(userDto);
			if (loginUser != null) {
				String token = jwtService.create("userid", loginUser.getUserId(), "access-token");// key, data, subject
				logger.debug("로그인 토큰정보 : {}", token);
				resultMap.put("access-token", token);
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			} else {
				resultMap.put("message", FAIL);
				status = HttpStatus.ACCEPTED;
			}
		} catch (Exception e) {
			logger.error("로그인 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}

	@GetMapping("/info/{userid}")
	public ResponseEntity<Map<String, Object>> getInfo(
			@PathVariable("userid") @ApiParam(value = "인증할 회원의 아이디.", required = true) String userid,
			HttpServletRequest request) {
//		logger.debug("userid : {} ", userid);
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		if (jwtService.isUsable(request.getHeader("access-token"))) {
			logger.info("사용 가능한 토큰!!!");
			try {
//				로그인 사용자 정보.
				UserDto userDto = userService.getUserById(userid);
				resultMap.put("userInfo", userDto);
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			} catch (Exception e) {
				logger.error("정보조회 실패 : {}", e);
				resultMap.put("message", e.getMessage());
				status = HttpStatus.INTERNAL_SERVER_ERROR;
			}
		} else {
			logger.error("사용 불가능 토큰!!!");
			resultMap.put("message", FAIL);
			status = HttpStatus.ACCEPTED;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}

	@PostMapping("/join")
	public ResponseEntity<String> join(@RequestBody UserDto userDto) throws Exception {
		System.out.println("join -> userDto : " + userDto);
		if (userService.registUser(userDto))
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@DeleteMapping("/delete")
	public ResponseEntity<String> delete(@PathVariable String userId) throws Exception {
		System.out.println("delete >>>>>>>>>>>" + userId);
		if (userService.deleteUser(userId)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@PutMapping("/modify")
	public ResponseEntity<String> modify(@RequestBody UserDto userDto) throws Exception {
		System.out.println("modify -> userDto : " + userDto);
		if (userService.updateUser(userDto))
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@GetMapping("/idcheck")
	public ResponseEntity<Map<String, Object>> idCheck(@RequestParam("ckid") String checkId) throws Exception {
		int idCount = userService.idCheck(checkId);
		System.out.println("idCheck -> checkId : " + checkId + " / idCount : " + idCount);
//		JSONObject json = new JSONObject();
//		json.put("idcount", idCount); // "{idcount : ' " +idCount+"'}"
//		return json.toString();
		Map<String, Object> resultMap = new HashMap<>();

		resultMap.put("idcount", idCount);
		resultMap.put("message", SUCCESS);
		return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
	}

	@PutMapping("/changeInterestArea")
	public ResponseEntity<String> changeInterestArea(@RequestBody UserDto userDto) {
		System.out.println("changeInterestArea -> userInterestDto : " + userDto);
		if (userService.updateInterestArea(userDto))
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@GetMapping("/getArea")
	public ResponseEntity<String> getArea(@RequestParam("userId") String userId) throws Exception {
		System.out.println("getArea -> userId : " + userId);
		return new ResponseEntity<String>(userService.getArea(userId), HttpStatus.OK);
	}

	@GetMapping
	public ResponseEntity<List<UserDto>> userList() throws Exception {
		return new ResponseEntity<List<UserDto>>(userService.listUser(), HttpStatus.OK);
	}
}
