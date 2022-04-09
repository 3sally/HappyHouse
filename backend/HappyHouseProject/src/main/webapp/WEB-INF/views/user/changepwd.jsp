<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!-- changePwd Button -->
<script type="text/javascript">
        $(document).ready(function () {
        	
        	// 회원가입
            $("#changePwd").click(function () {
                if (!$("#newpwd").val()) {
                    alert("새 비번 쓰기!!!");
                    return;
                }	else {
                    $("#changeform").attr("action", "${root}/user/changepwd").submit();
                }
            });

        });
    </script>    
    
    
 <!-- change password modal Modal HTML -->
  <div id="change-pwd-modal" class="modal fade">
    <div class="modal-dialog modal-login">
      <div class="modal-content">
        <div class="modal-header">	
          <h2>비밀번호 변경</h2>
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div><hr>
        <div class="modal-body">
          <form id="changeform" action="" method="post">
          <input type="hidden" name="userId" value="${user.userId}">
            
            <div class="form-group">
              <div class="input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-lock"></i>
                  </span>                    
                </div>
                <input type="text" class="form-control form-control-mypage" id ="newpwd" name="userPass" placeholder="새 비밀번호" required="required">
              </div>
            </div>
            
            <div class="form-group text-right">
              <button id="changePwd" type="submit" class="btn btn-primary">저장</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>