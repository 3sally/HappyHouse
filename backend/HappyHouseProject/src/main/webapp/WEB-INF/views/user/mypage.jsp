<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/user/changepwd.jsp" %>

<c:if test="${!empty userinfo}">
	<c:if test="${!empty msg}">
	<script>
		alert("${msg}");
	</script>
	</c:if>
	<br><br><br>
<section class="page-section mb-0 text-secondary" id="mypage">
    <div class="container">
      <h2 class="page-section-heading text-center text-uppercase">마이페이지</h2>
      <div class="divider-custom">
        <div class="divider-custom-line"></div>
        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
        <div class="divider-custom-line"></div>
      </div>
      <div class="row mypage">
        <table class="table table-bordered">
          <tbody>
            <tr>
              <th class="bg-primary text-white text-center">이름</th>
              <td class="bg-white">${user.userName}</td>
            </tr>
            <tr>
              <th class="bg-primary text-white text-center">아이디</th>
              <td class="bg-white">${user.userId}</td>
            </tr>
             <tr>
              <th class="bg-primary text-white text-center">비밀번호</th>
              <td class="bg-white">${user.userPass}</td>
            </tr>
            <tr>
              <th class="bg-primary text-white text-center">이메일</th>
              <td class="bg-white">${user.userEmail}</td>
            </tr>
            <tr>
              <th class="bg-primary text-white text-center">전화번호</th>
              <td class="bg-white">${user.userPhone}</td>
            </tr>
            <tr>
              <th class="bg-primary text-white text-center">주소</th>
              <td class="bg-white">${user.userAddr}</td>
            </tr>
          </tbody>
        </table>
        <div class="text-right">
          <button type="button" class="btn btn-primary btn-write"  href="#change-pwd-modal" data-toggle="modal">비밀번호 변경</button>
        </div>
      </div>
    </div>
  </section>
  </c:if>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>