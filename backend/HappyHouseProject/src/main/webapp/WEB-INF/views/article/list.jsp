<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<c:if test="${!empty userinfo}">
	<script type="text/javascript">
	        $(document).ready(function () {
	            $("#mvRegisterBtn").click(function () {
	                location.href = "${root}/article/register";
	            });
	        });
	</script>
	 
 
 
 <br>
 <br>
 <br>
   
    
 <!-- About Section-->
  <section class="page-section mb-0 text-secondary" id="about">
    <div class="container">
      <!-- About Section Heading-->
      <h2 class="page-section-heading text-center text-uppercase">공지사항</h2>
      <!-- Icon Divider-->
      <div class="divider-custom">
        <div class="divider-custom-line"></div>
        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
        <div class="divider-custom-line"></div>
      </div>
      <!-- About Section Content-->
      <div class="row about">
        <table class="table table-hover">
          <thead class="thead-light bg-primary text-white w-100">
            <tr>
              <th>#</th>
              <th class="title">제목</th>
              <th class="date">등록일</th>
            </tr>
          </thead>
          <tbody>
      	<c:if test="${!empty articles}">
      		<c:forEach var="article" items="${articles}">
	            <tr>
	              <td class="no">${article.articleNo}</td>
	              <td class="title">${article.subject}      
	              <c:if test="${userinfo.userId eq article.userId}">
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="${root}/article/modify?articleno=${article.articleNo}">수정</a>
					<a href="${root}/article/delete?articleno=${article.articleNo}">삭제</a>
				  </c:if>
				  </td>
	              <td class="date">${article.regTime}</td>
	            </tr>
	             
	        </c:forEach>
	        <div class="m-3 row justify-content-center">${navigation.navigator}</div>
        </c:if>
        <c:if test="${empty articles}">
        	<tr >
	            <td colspan="3" align ="center"> 등록된 글이 없습니다. </td>
	       </tr>
        </c:if>
         </tbody>
       </table>
        <div>
         
       	 <c:if test="${userinfo.userId eq 'adminKing'}">
          <button id = "mvRegisterBtn" type="button" class="btn btn-primary btn-write">글쓰기</button>
          </c:if>
        </div>
      </div>
    </div>
  </section>
  </c:if>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>