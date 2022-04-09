package com.ssafy.happyhouseproject.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import com.ssafy.happyhouseproject.model.NoticeDto;
import com.ssafy.happyhouseproject.model.service.NoticeService;

@CrossOrigin
@RestController
@RequestMapping("/notice")
public class NoticeController {

	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

	@Autowired
	private NoticeService noticeService;

	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@GetMapping
	public ResponseEntity<List<NoticeDto>> noticeList() throws Exception {
		System.out.println("noticeList()");
		return new ResponseEntity<List<NoticeDto>>(noticeService.listArticle(), HttpStatus.OK);
	}

	@GetMapping("/hot")
	public ResponseEntity<List<NoticeDto>> hotNoticeList() throws Exception {
		System.out.println("hotNoticeList()");
		return new ResponseEntity<List<NoticeDto>>(noticeService.hotListArticle(), HttpStatus.OK);
	}

	@PutMapping("/{articleno}")
	public ResponseEntity<String> increaseViews(@PathVariable int articleno) throws Exception {
		System.out.println("increaseViews() articleno => " + articleno);
		if (noticeService.increaseViews(articleno)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@GetMapping("/{articleno}")
	public ResponseEntity<NoticeDto> getNotice(@PathVariable int articleno) throws Exception {
		return new ResponseEntity<NoticeDto>(noticeService.getArticle(articleno), HttpStatus.OK);
	}

	@PostMapping
	public ResponseEntity<String> createNotice(@RequestBody NoticeDto noticeDto) throws Exception {
		if (noticeService.registerArticle(noticeDto)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@PutMapping
	public ResponseEntity<String> modifyNotice(@RequestBody NoticeDto noticeDto) throws Exception {
		System.out.println(noticeDto);
		if (noticeService.updateArticle(noticeDto)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@DeleteMapping("/{articleno}")
	public ResponseEntity<String> deleteNotice(@PathVariable int articleno) throws Exception {
		System.out.println("deleteNotice()");
		if (noticeService.deleteArticle(articleno)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
}
