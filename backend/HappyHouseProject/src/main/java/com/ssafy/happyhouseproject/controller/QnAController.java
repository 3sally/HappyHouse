package com.ssafy.happyhouseproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouseproject.model.QnADto;
import com.ssafy.happyhouseproject.model.service.QnAService;

@CrossOrigin
@RestController
@RequestMapping("/qna")
public class QnAController {

	@Autowired
	private QnAService qnAService;

	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@GetMapping
	public ResponseEntity<List<QnADto>> qnAList() throws Exception {
		return new ResponseEntity<List<QnADto>>(qnAService.getQnAList(), HttpStatus.OK);
	}

	@GetMapping("/myqna/{userId}")
	public ResponseEntity<List<QnADto>> myQnAList(@PathVariable String userId) throws Exception {
		System.out.println("myQnAList -> " + userId);
		return new ResponseEntity<List<QnADto>>(qnAService.getMyQnAList(userId), HttpStatus.OK);
	}

	@GetMapping("/{qnano}")
	public ResponseEntity<QnADto> searchQnA(@PathVariable int qnano) throws Exception {
		return new ResponseEntity<QnADto>(qnAService.search(qnano), HttpStatus.OK);
	}

	@PostMapping
	public ResponseEntity<String> createQnA(@RequestBody QnADto qnADto) throws Exception {
		if (qnAService.create(qnADto)) {
			System.out.println(qnADto);
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@PutMapping
	public ResponseEntity<String> modifyQnA(@RequestBody QnADto qnADto) throws Exception {
		if (qnAService.modify(qnADto)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@DeleteMapping("/{qnano}")
	public ResponseEntity<String> deleteQnA(@PathVariable int qnano) throws Exception {
		if (qnAService.delete(qnano)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
}
