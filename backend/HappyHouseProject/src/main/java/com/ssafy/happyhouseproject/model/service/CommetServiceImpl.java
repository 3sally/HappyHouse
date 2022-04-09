package com.ssafy.happyhouseproject.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouseproject.model.CommentDto;
import com.ssafy.happyhouseproject.model.mapper.CommentMapper;

@Service
public class CommetServiceImpl implements CommentService {
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<CommentDto> searchComments(int qnano) throws Exception {
		return sqlSession.getMapper(CommentMapper.class).searchComments(qnano);
	}

	@Override
	public boolean create(CommentDto commentDto) throws Exception {
		return sqlSession.getMapper(CommentMapper.class).create(commentDto);
	}

	@Override
	public boolean modify(CommentDto commentDto) throws Exception {
		return sqlSession.getMapper(CommentMapper.class).modify(commentDto);
	}

	@Override
	public boolean delete(int qnano) throws Exception {
		return sqlSession.getMapper(CommentMapper.class).delete(qnano);
	}

}
