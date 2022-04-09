<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<c:if test="${cookie.hh_id.value ne null}">
	<c:set var="idck" value=" checked"/>
	<c:set var="saveid" value="${cookie.hh_id.value}"/>
</c:if>


<script type="text/javascript">
        $(document).ready(function () {
            $("#loginBtn").click(function () {
                if (!$("#loginid").val()) {
                    alert("아이디 입력!!!");
                    return;
                } else if (!$("#loginpass").val()) {
                    alert("비밀번호 입력!!!");
                    return;
                } else {
                    $("#loginform").attr("action", "${root}/user/login").submit();
                }
            });
        });
</script>
    
<!-- Login Modal HTML -->
  <div id="login-modal" class="modal fade">
    <div class="modal-dialog modal-login">
      <div class="modal-content">
        <div class="modal-header">            
          <h4 class="modal-title">로그인</h4>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
          <form action="" method="post" id="loginform">
           <div class="form-group form-check text-right">
                    <label class="form-check-label">
                        <input class="form-check-input" type="checkbox" id="idsave" name="idsave" value="saveok"${idck}> 아이디저장
                    </label>
                </div>
            <div class="form-group">
              <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-user"></i></span>
               <input type="text" class="form-control" id="loginid" name="userId" placeholder="" value="${saveid}">
              </div>
            </div>
            <div class="form-group">
              <div class="input-group">
                <span class="input-group-addon"></span><i class="fa fa-lock"></i>
                <input type="password" class="form-control" id="loginpass" name="userPass" placeholder="">
              </div>
            </div>
            <div class="form-group">
              <button id="loginBtn" type="button" class="btn btn-primary btn-block btn-lg">로그인</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>