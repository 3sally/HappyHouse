package com.ssafy.happyhouseproject.model.mapper;

import java.util.List;

import com.ssafy.happyhouseproject.model.QnADto;

public interface QnAMapper {
	List<QnADto> getQnAList() throws Exception;

	QnADto search(int qnano) throws Exception;

	boolean create(QnADto qnADto) throws Exception;

	boolean modify(QnADto qnADto) throws Exception;

	boolean delete(int qnano) throws Exception;

	List<QnADto> getMyQnAList(String userId) throws Exception;
}
