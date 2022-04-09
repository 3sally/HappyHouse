<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- register Button -->
<script type="text/javascript">

        $(document).ready(function () {
        	var isId = true;
        	
        	var interestArea = ["", "", ""]
        	// 아이디 중복검사
        	$("#userid").keyup(function () {
        		var ckid = $("#userid").val();
        		if(ckid.length < 6 || ckid.length > 16) {
        			$("#idresult").text("아이디는 6자이상 16자이하입니다.").removeClass('text-primary').removeClass('text-danger').addClass('text-dark');
        			isId = false;
        		} else {
	                $.ajax({
	                	url: '${root}/user/idcheck',
	                	data: {'ckid': ckid},
	                  	type: 'GET',
	                  	dataType: 'json',
	                  	success: function (response) {
	                  		console.log(response);
	                    	var cnt = response.idcount;
	                    	if(cnt == 0) {
	                    		$("#idresult").text(ckid + "는 사용가능합니다.").removeClass('text-dark').removeClass('text-danger').addClass('text-primary');
	                    		isId = true;
	                    	} else {
	                    		$("#idresult").text(ckid + "는 사용할 수 없습니다.").removeClass('text-dark').removeClass('text-primary').addClass('text-danger');
	                    		isId = false;
	                    	}
	                  	}, 
	                  	error: function(request, status, error) {
	                  		console.log("status : " + request.status + "\tmsg : " + error);
	                  	}
					});
        		}
			}); 
        	
        	// 회원가입
            $("#registerBtn").click(function () {
                if (!$("#username").val()) {
                    alert("이름 입력!!!");
                    return;
                } else if (!isId) {
                    alert("아이디 확인!!!");
                    return;
                } else if (!$("#userpass").val()) {
                    alert("비밀번호 입력!!!");
                    return;
                } else if ($("#userpass").val() != $("#pwdcheck").val()) {
                    alert("비밀번호 확인!!!");
                    return;
                } else if (!$("#emailid").val()) {
                    alert("이메일 입력!!!");
                    return;
                }else if (!$("#tel2").val() || !$("#tel3").val()) {
                    alert("전화번호 입력!!!");
                    return;
                }else if (!$("#zipcode").val()) {
                    alert("주 입력!!!");
                    return;
                }else {
                	$("#email").val($("#emailid").val() + "@" + $("#emaildomain").val());
                	$("#tel").val($("#tel1").val() + "-" + $("#tel2").val()+ "-" +$("#tel3").val());
                    $("#memberform").attr("action", "${root}/user/register?interestArea=" + interestArea.join("_")).submit();
                }
            });
        	
            $.get("/map/sido",
					function (data, status) {
						$.each(data, function (index, vo) {
							$("#usersido").append(
								'<li data_code="' +
									vo.sidoCode +
									'" class="dropdown-item sido">' +
									vo.sidoName +
									"</li>"
							);
						}); // each
					}, // function
					"json"
				); // get
				
        	// 시 / 도 선택
			$(document).on("click", ".dropdown-item.sido", function () {

				var bArea = $(this).text();
				$("#sidoBtn").text(bArea);
				$.get(
					"/map/gugun",
					{ sido: $(this).attr("data_code") },
					function (data, status) {
						$("#usergugun").empty();
						$.each(data, function (index, vo) {
							$("#usergugun").append(
								'<li data_code="' +
									vo.gugunCode +
									'" class="dropdown-item gugun">' +
									vo.gugunName +
									"</li>"
							);
						}); // each
					}, // function
					"json"
				); // get
				
			
				interestArea[0] = bArea;
				
				$("#gugunBtn").text("구/군 선택");

				$("#dongBtn").text("동 선택");
			});

			// 구 / 군 선택
			$(document).on("click", ".dropdown-item.gugun", function () {

				var mArea = $(this).text();
				$("#gugunBtn").text(mArea);

				$.get(
					"/map/dong",
					{ gugun: $(this).attr("data_code") },
					function (data, status) {
						$("#userdong").empty();
						$.each(data, function (index, vo) {
							$("#userdong").append(
								'<li data_code="' +
									vo.dongCode +
									'" class="dropdown-item dong">' +
									vo.dongName +
									"</li>"
							);
						}); // each
					}, // function
					"json"
				); // get
				interestArea[1] = mArea;
				$("#dongBtn").text("동 선택");
			});

			// 동 선택
			$(document).on("click", ".dropdown-item.dong", function () {
				var sArea = $(this).text();
				var sArea_code = $(this).attr("data_code");
				$("#dongBtn").text(sArea);
				
				interestArea[2] = sArea;
			});
			
			
        });
    </script>    
    
<!-- signup Modal HTML -->
  <div id="signup-modal" class="modal fade">
    <div class="modal-dialog modal-login">
      <div class="modal-content">
        <div class="modal-header">            
          <h2>회원가입</h2><hr>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
          <form id="memberform" action="" method="post">
              <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text">
                    <span class="fa fa-user"></span>
                  </span>                    
                </div>
                <input type="text" class="form-control" id="username" name="userName" placeholder="이름입력...">
              </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text">
                    <span class="fa fa-user"></span>
                  </span>                    
                </div>
                <input type="text" class="form-control" id="usi" name="userId" placeholder="아이디입력...">
              </div>
              <div id="idresult" class="mt-1"></div>
            </div>
            <div class="form-group">
              <div class="input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-lock"></i>
                  </span>                    
                </div>
                <input type="password" class="form-control" id="userpass" name="userPass" placeholder="비밀번호입력...">
              </div>
            </div>
            <div class="form-group">
              <div class="input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-lock"></i>
                  </span>                    
                </div>
                <input type="password" class="form-control" id="pwdcheck" name="pwdcheck" placeholder="비밀번호재입력...">
              </div>
            </div>
            <div class="form-group">
              <div class="input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-paper-plane"></i>
                  </span>                    
                </div>
                <div id="email" class="custom-control-inline">
                        <input type="text" class="form-control" id="emailid" name="emailid" placeholder="이메일아이디입력..."
                            size="25"> @
                        <select class="form-control" id="emaildomain" name="emaildomain">
                            <option value="ssafy.com">싸피</option>
                            <option value="naver.com">네이버</option>
                            <option value="kakao.com">카카오</option>
                            <option value="google.com">구글</option>
                        </select>
                    </div>
              </div>
            </div>
            <div class="form-group">
              <div class="input-group">
                
                 <div id="tel" class="custom-control-inline">
                        <select class="form-control" id="tel1" name="tel1">
                            <option value="010">010</option>
                            <option value="02">02</option>
                            <option value="031">031</option>
                            <option value="032">032</option>
                            <option value="041">041</option>
                            <option value="051">051</option>
                            <option value="061">061</option>
                        </select> _
                        <input type="text" class="form-control" id="tel2" name="tel2" placeholder=""> _
                        <input type="text" class="form-control" id="tel3" name="tel3" placeholder="">
                    </div>
              </div>
            </div>
            <div class="form-group">
            	<div class="input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-lock"></i>
                  </span>                    
                </div>
                <input type="text" class="form-control" id="zipcode" name="userAddr" placeholder="주소입력...">
       			</div>
       		</div>
       			<hr>
       			<div class="form-group">
	       			<div class="dropdown">
	       			나의 관심 지역 설정 &nbsp;&nbsp;&nbsp;
						<div class="btn-group">
							<button type="button" id="sidoBtn"
								class="btn btn-info dropdown-toggle" data-bs-toggle="dropdown"
								aria-expanded="false">시/도 선택</button>
							<ul id="usersido" class="dropdown-menu">
							</ul>
						</div>
						<div class="btn-group">
							<button type="button" id="gugunBtn"
								class="btn btn-info dropdown-toggle" data-bs-toggle="dropdown"
								aria-expanded="false">구/군 선택</button>
	
							<ul id="usergugun" class="dropdown-menu"></ul>
						</div>
						<div class="btn-group">
							<button type="button" id="dongBtn"
								class="btn btn-info dropdown-toggle" data-bs-toggle="dropdown"
								aria-expanded="false">동 선택</button>
							<ul id="userdong" class="dropdown-menu"></ul>
						</div>
					</div>
            	</div>
            <div class="form-group">
              <button type="button" id="registerBtn" class="btn btn-primary btn-block">회원 가입하기</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  