<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<c:if test="${!empty userinfo}">
 <script type="text/javascript">
        $(document).ready(function () {
            $("#modifyBtn").click(function () {
                if (!$("#subject").val()) {
                    alert("제목 입력!!!!");
                    return;
                } else if (!$("#content").val()) {
                    alert("내용 입력!!!!");
                    return;
                } else {
                    $("#writeform").attr("action", "${root}/article/modify").submit();
                }
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
      <h2 class="page-section-heading text-center text-uppercase">공지 글 수정하기</h2>
      <!-- Icon Divider-->
      <div class="divider-custom">
        <div class="divider-custom-line"></div>
        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
        <div class="divider-custom-line"></div>
      </div>
      <!-- About Section Content-->
     <div class="container text-center mt-3">
        <div class="col-lg-8 mx-auto">
            <form id="writeform" class="text-left mb-3" method="post" action="">
            	<input type="hidden" name="articleNo" value="${article.articleNo}">
                <div class="form-group">
                    <label for="subject">제목:</label>
                    <input type="text" class="form-control" id="subject" name="subject" value="${article.subject }">
                </div>
                <div class="form-group">
                    <label for="content">내용:</label>
                    <textarea class="form-control" rows="15" id="content" name="content">${article.content }</textarea>
                </div>
                <div class="text-center">
                    <button type="button" id="modifyBtn" class="btn btn-outline-primary">수정</button>
                </div>
            </form>
        </div>
    </div>
  </section>
  </c:if>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>