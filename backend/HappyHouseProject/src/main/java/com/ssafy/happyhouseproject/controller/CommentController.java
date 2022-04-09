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

import com.ssafy.happyhouseproject.model.CommentDto;
import com.ssafy.happyhouseproject.model.service.CommentService;

@CrossOrigin
@RestController
@RequestMapping("/comment")
public class CommentController {

	@Autowired
	private CommentService commentService;

	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@GetMapping("/{qnano}")
	public ResponseEntity<List<CommentDto>> searchComments(@PathVariable int qnano) throws Exception {
		System.out.println(">>>>>" + qnano);
		return new ResponseEntity<List<CommentDto>>(commentService.searchComments(qnano), HttpStatus.OK);
	}

	@PostMapping
	public ResponseEntity<String> createComment(@RequestBody CommentDto commentDto) throws Exception {
		if (commentService.create(commentDto)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@PutMapping
	public ResponseEntity<String> modifyComment(@RequestBody CommentDto commentDto) throws Exception {
		System.out.println("modifyComment ->" + commentDto);
		if (commentService.modify(commentDto)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		System.out.println(commentDto);
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@DeleteMapping("/{qnano}")
	public ResponseEntity<String> deleteComment(@PathVariable int qnano) throws Exception {
		if (commentService.delete(qnano)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
}
