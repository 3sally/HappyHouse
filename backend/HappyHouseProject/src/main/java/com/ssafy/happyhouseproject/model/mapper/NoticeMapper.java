package com.ssafy.happyhouseproject.model.mapper;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouseproject.model.NoticeDto;

public interface NoticeMapper {

	List<NoticeDto> listArticle() throws Exception;

	NoticeDto getArticle(int articleNo) throws Exception;

	boolean registerArticle(NoticeDto noticeDto) throws Exception;

	boolean updateArticle(NoticeDto noticeDto) throws Exception;

	boolean deleteArticle(int articleNo) throws Exception;

	int getTotalCount(Map<String, String> map) throws Exception;

	List<NoticeDto> hotListArticle() throws Exception;

	boolean increaseViews(int articleNo) throws Exception;

}
