package com.ssafy.happyhouseproject.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouseproject.model.NoticeDto;
import com.ssafy.util.PageNavigation;

public interface NoticeService {

	List<NoticeDto> listArticle() throws Exception;

	NoticeDto getArticle(int articleNo) throws Exception;

	boolean registerArticle(NoticeDto noticeDto) throws Exception;

	boolean updateArticle(NoticeDto noticeDto) throws Exception;

	boolean deleteArticle(int articleNo) throws Exception;

	PageNavigation makePageNavigation(Map<String, String> map) throws Exception;

	List<NoticeDto> hotListArticle() throws Exception;

	boolean increaseViews(int articleno) throws Exception;

}
