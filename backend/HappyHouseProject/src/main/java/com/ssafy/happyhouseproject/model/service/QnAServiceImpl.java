package com.ssafy.happyhouseproject.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouseproject.model.QnADto;
import com.ssafy.happyhouseproject.model.mapper.QnAMapper;

@Service
public class QnAServiceImpl implements QnAService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<QnADto> getQnAList() throws Exception {
		return sqlSession.getMapper(QnAMapper.class).getQnAList();
	}

	@Override
	public QnADto search(int qnano) throws Exception {
		return sqlSession.getMapper(QnAMapper.class).search(qnano);
	}

	@Override
	public boolean create(QnADto qnADto) throws Exception {
		return sqlSession.getMapper(QnAMapper.class).create(qnADto);
	}

	@Override
	public boolean modify(QnADto qnADto) throws Exception {
		return sqlSession.getMapper(QnAMapper.class).modify(qnADto);
	}

	@Override
	public boolean delete(int qnano) throws Exception {
		return sqlSession.getMapper(QnAMapper.class).delete(qnano);
	}

	@Override
	public List<QnADto> getMyQnAList(String userId) throws Exception {
		return sqlSession.getMapper(QnAMapper.class).getMyQnAList(userId);
	}
}
