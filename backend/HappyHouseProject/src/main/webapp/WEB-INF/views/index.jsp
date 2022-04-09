<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ include file="/WEB-INF/views/user/login.jsp"%>
<%@ include file="/WEB-INF/views/user/join.jsp"%>
<c:if test="${!empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>
<%-- <link href="${root}/css/map.css" rel="stylesheet" /> --%>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
	integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
	integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
	crossorigin="anonymous"></script>
<header class="masthead bg-primary text-white text-center">
	<div class="container d-flex align-items-center flex-column">
		<!-- Masthead Avatar Image-->
		<img class="masthead-avatar mb-5" src="/img/cabin.png" alt="..." />
		<!-- Masthead Heading-->
		<h1 class="masthead-heading text-uppercase mb-0">Welcome Happy
			House!</h1>

		<!-- Icon Divider-->
		<div class="divider-custom divider-light">
			<div class="divider-custom-line"></div>
			<div class="divider-custom-icon">
				<i class="fas fa-star"></i>
			</div>
			<div class="divider-custom-line"></div>
		</div>
		<!-- Masthead Subheading-->
		<p class="masthead-subheading font-weight-light mb-0">by Jang Dong
			Jae & Lee MinJung</p>
	</div>
</header>

<script src="/js/scripts.js"></script>

<section class="page-section happyhouse" id="happyhouse">
	<div class="container">
		<h2
			class="page-section-heading text-center text-uppercase text-secondary mb-0">Map
			Search</h2>
		<!-- Icon Divider-->
		<div class="divider-custom">
			<div class="divider-custom-line"></div>
		</div>

		<div id="content-wrapper">
			<!-- 지도 셀렉트 바 -->
			<br />
			<div class="text-center mb-2">
				<div class="dropdown">
					<div class="btn-group">
						<button type="button" id="big_areaBtn"
							class="btn btn-warning dropdown-toggle" data-bs-toggle="dropdown"
							aria-expanded="false">시/도 선택</button>
						<ul id="sido" class="dropdown-menu">
						</ul>
					</div>
					<div class="btn-group">
						<button type="button" id="middle_areaBtn"
							class="btn btn-warning dropdown-toggle" data-bs-toggle="dropdown"
							aria-expanded="false">구/군 선택</button>

						<ul id="gugun" class="dropdown-menu"></ul>
					</div>
					<div class="btn-group">
						<button type="button" id="small_areaBtn"
							class="btn btn-warning dropdown-toggle" data-bs-toggle="dropdown"
							aria-expanded="false">동 선택</button>
						<ul id="dong" class="dropdown-menu"></ul>
					</div>
				</div>
				<div>
					<div style="margin-top: 20px">
						<input id="searchAptName" type="text" class="form-control-static"
							placeholder="지역구 내 아파트명" />
						<button type="button" id="searchBtn" class="btn btn-primary">조회</button>
						<div align="right">
							<button type="button" id="interestBtn" class="btn btn-primary" uid="${userinfo.userId}">관심지역으로
								조회</button>
						</div>
					</div>
				</div>
				<hr />

				<div class="row">
					<!-- 건물 정보 -->
					<div id="aptInfo" data-spy="scroll" class="col-sm-3"
						style="overflow-y: scroll; width: 30%; height: 600px; display: none; padding-left: 50px; padding-bottom: 20px;"></div>
					<!-- 지도 -->
					<div id="map" style="width: 100%; height: 600px"></div>
				</div>
				<!-- 아랫 부분 -->
				<div class="row white">
					<div class="single-metas fade-down centered"></div>
					<hr />
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="dealInfoModal" tabindex="-1"
		aria-labelledby="dealInfoModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="dealInfoModalLabel">거래 정보 확인</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div id="dealInfoModalBody" class="modal-body">...</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

</section>


<%@ include file="/WEB-INF/views/include/footer.jsp"%>