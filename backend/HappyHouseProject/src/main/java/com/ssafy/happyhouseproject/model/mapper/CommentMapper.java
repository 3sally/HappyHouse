package com.ssafy.happyhouseproject.model.mapper;

import java.util.List;

import com.ssafy.happyhouseproject.model.CommentDto;

public interface CommentMapper {

	List<CommentDto> searchComments(int qnano) throws Exception;

	boolean create(CommentDto commentDto) throws Exception;

	boolean modify(CommentDto commentDto) throws Exception;

	boolean delete(int qnano) throws Exception;
}
