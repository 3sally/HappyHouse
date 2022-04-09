package com.ssafy.happyhouseproject.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouseproject.model.NoticeDto;
import com.ssafy.happyhouseproject.model.mapper.NoticeMapper;
import com.ssafy.util.PageNavigation;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<NoticeDto> listArticle() throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).listArticle();
	}

	@Override
	public List<NoticeDto> hotListArticle() throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).hotListArticle();
	}

	@Override
	public NoticeDto getArticle(int articleNo) throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).getArticle(articleNo);
	}

	@Override
	public boolean registerArticle(NoticeDto noticeDto) throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).registerArticle(noticeDto);
	}

	@Override
	public boolean updateArticle(NoticeDto noticeDto) throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).updateArticle(noticeDto);
	}

	@Override
	public boolean deleteArticle(int articleNo) throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).deleteArticle(articleNo);
	}

	@Override
	public PageNavigation makePageNavigation(Map<String, String> map) throws Exception {
		PageNavigation pageNavigation = new PageNavigation();
		int naviSize = 10;
		int currentPage = Integer.parseInt(map.get("pg") == null ? "1" : map.get("pg"));
		int sizePerPage = Integer.parseInt(map.get("spp"));

		pageNavigation.setCurrentPage(currentPage);
		pageNavigation.setNaviSize(naviSize);
		int totalCount = sqlSession.getMapper(NoticeMapper.class).getTotalCount(map);
		pageNavigation.setTotalCount(totalCount);
		int totalPageCount = (totalCount - 1) / sizePerPage + 1;
		pageNavigation.setTotalPageCount(totalPageCount);
		boolean startRange = currentPage <= naviSize;
		pageNavigation.setStartRange(startRange);
		boolean endRange = (totalPageCount - 1) / naviSize * naviSize < currentPage;
		pageNavigation.setEndRange(endRange);
		pageNavigation.makeNavigator();

		return pageNavigation;
	}

	@Override
	public boolean increaseViews(int articleNo) throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).increaseViews(articleNo);
	}

}
