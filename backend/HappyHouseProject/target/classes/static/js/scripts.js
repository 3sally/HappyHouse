var map, marker, geocoder;
			var markers = [];
			
			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png";

			var smallInfos = [];

			$(document).ready(function () {
				$.get("/map/sido",
					function (data, status) {
						$.each(data, function (index, vo) {
							$("#sido").append(
								'<li data_code="' +
									vo.sidoCode +
									'" class="dropdown-item big_area">' +
									vo.sidoName +
									"</li>"
							);
						}); // each
					}, // function
					"json"
				); // get
			}); // ready

			$("document").ready(function () {
				var container = document.getElementById("map"); // 지도를 담을 영역의
																// DOM 레퍼런스
				var options = {
					// 지도를 생성할 때 필요한 기본 옵션
					center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의
																			// 중심좌표.
					level: 3, // 지도의 레벨(확대, 축소 정도)
				};

				map = new kakao.maps.Map(container, options); // 지도 생성 및 객체 리턴

				// 마커가 표시될 위치입니다
				var locPosition = new kakao.maps.LatLng(33.450701, 126.570667);

				// 마커를 생성합니다
				marker = new kakao.maps.Marker({
					position: locPosition,
				});

				// 마커가 지도 위에 표시되도록 설정합니다
				if (navigator.geolocation) {
					// GeoLocation을 이용해서 접속 위치를 얻어옵니다
					navigator.geolocation.getCurrentPosition(function (position) {
						var lat = position.coords.latitude, // 위도
							lon = position.coords.longitude; // 경도

						locPosition = new kakao.maps.LatLng(lat, lon); // 마커가
																		// 표시될
																		// 위치를
																		// geolocation으로
																		// 얻어온
																		// 좌표로
																		// 생성합니다
						var message = ""; // 인포윈도우에 표시될 내용입니다

						// 마커와 인포윈도우를 표시합니다
						displayMarker(locPosition, 0);

						map.setCenter(locPosition);
					});
				} else {
					// HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
					displayMarker(locPosition);
					map.setCenter(locPosition);
				}

				// 시 / 도 선택
				$(document).on("click", ".dropdown-item.big_area", function () {
					offDisplay();

					var bArea = $(this).text();
					$("#big_areaBtn").text(bArea);
					$.get(
						"/map/gugun",
						{ sido: $(this).attr("data_code") },
						function (data, status) {
							$("#gugun").empty();
							$.each(data, function (index, vo) {
								$("#gugun").append(
									'<li data_code="' +
										vo.gugunCode +
										'" class="dropdown-item middle_area">' +
										vo.gugunName +
										"</li>"
								);
							}); // each
						}, // function
						"json"
					); // get
					
					$("#middle_areaBtn").text("구/군 선택");

					$("#small_areaBtn").text("동 선택");
				});

				// 구 / 군 선택
				$(document).on("click", ".dropdown-item.middle_area", function () {
					offDisplay();

					var mArea = $(this).text();
					$("#middle_areaBtn").text(mArea);

					$.get(
						"/map/dong",
						{ gugun: $(this).attr("data_code") },
						function (data, status) {
							$("#dong").empty();
							$.each(data, function (index, vo) {
								$("#dong").append(
									'<li data_code="' +
										vo.dongCode +
										'" class="dropdown-item small_area">' +
										vo.dongName +
										"</li>"
								);
							}); // each
						}, // function
						"json"
					); // get

					$("#small_areaBtn").text("동 선택");
				});

				// 동 선택
				$(document).on("click", ".dropdown-item.small_area", function () {
					var sArea = $(this).text();
					var sArea_code = $(this).attr("data_code");
					$("#small_areaBtn").text(sArea);

					onDisplay();
					makeSmallList(sArea, sArea_code);
				});

				// 검색
				$("#searchBtn").on("click", function () {
					// 유효성 검사 거치고
					var bArea = $("#big_areaBtn").text().trim();
					var mArea = $("#middle_areaBtn").text().trim();
					var sArea = $("#small_areaBtn").text().trim();
					
					if (bArea.includes("선택") || mArea.includes("선택") || sArea.includes("선택")) {
						alert("지역을 모두 선택한 뒤 검색을 눌러주세요");
						return;
					}

					var tempAptName = $("#searchAptName").val();

					var tempApt = smallInfos.filter((v) => v.aptName.includes(tempAptName));

					removeMarkers();
					$("#aptInfo").empty();
					$("#aptInfo").append("<h1>검색 결과</h1>");

					if (tempApt.length > 0) {
						tempApt.forEach((vo, idx) => {
							var apt =
								'<div class="aptDetailInfo" aptCode="' + vo.aptCode + '" data-bs-toggle="modal" data-bs-target="#dealInfoModal">' +
								"<h5>" +
								(idx + 1) + ". " + vo.aptName +
								"</h5>" +
								"<div>건축 연도 : " + vo.buildYear + "</div>" + 
								"<div>위치 : " + vo.dongName + "</div></br>";

							$("#aptInfo").append(apt);
							var tempLatLon = new kakao.maps.LatLng(vo.lat, vo.lng);
							displayMarker(tempLatLon, idx);
						});

						var moveLatLon = new kakao.maps.LatLng(tempApt[0].lat, tempApt[0].lng);

						// 지도 중심을 이동 시킵니다
						map.setCenter(moveLatLon);
					} else {
						$("#aptInfo").append("검색 결과가 없습니다");
					}
				});
				
				// 아파트 눌렀을 때
				$(document).on("click", ".aptDetailInfo", function () {
					let currentAptCode = $(this).attr("aptCode")
					
					let currentApt = smallInfos.filter(v => v.aptCode == currentAptCode)[0]
					
					var locPosition = new kakao.maps.LatLng(currentApt.lat, currentApt.lng);
					map.setCenter(locPosition)
					
					$("#dealInfoModalLabel").html(`<h5>" ${currentApt.aptName} "의 거래 정보 확인</h5>`)
					console.log(currentApt)
					// 모달에 등록하기
					$.get(
						"/map/deal",
						{ aptCode: currentAptCode },
						function (data, status) {
							$("#dealInfoModalBody").empty();
							$.each(data, function (index, vo) {
								$("#dealInfoModalBody").append(
										`<div>
											<h5>현황 ${index + 1}.</h5>
											<div> 거래일자 : ${vo.dealYear}. ${vo.dealMonth}. ${vo.dealDay} </div>
											<div> 면적 : ${vo.area} </div>
											<div> 층 : ${vo.floor} </div>
											<div> 거래금액 : ${vo.dealAmount.trim()} (단위: 만원)</div>
										</div>
										</br>`
								);
							}); // each
						}, // function
						"json"
					); // get
				})
				
				// 관심지역으로 조회눌렀을 때
				$("#interestBtn").on("click", function() {
					console.log($(this).attr("uid"))
					if (!$(this).attr("uid")) {
						alert("로그인 후 이용해주세요!")
						return;
					}
					
					$.get("/user/interest", {userId : $(this).attr("uid")},
							function (data, status) {
								const [big_area_name, middle_area_name, small_area_name] = data.split('_')
								$("#big_areaBtn").text(big_area_name);
								$("#middle_areaBtn").text(middle_area_name);
								$("#small_areaBtn").text(small_area_name);
								$.get(
										// dongCode 가져오기
										"/map/base", {sidoName : big_area_name, gugunName : middle_area_name, dongName : small_area_name},
										function (data, status) {
											let dongCode = data.dongCode;
											
											// 시도 코드 및 구군 코드 알았음
											let sidoCode = dongCode.substring(0, 2);
											let gugunCode = dongCode.substring(0, 5);
											
											// 구군 설정
											$.get(
												"/map/gugun",
												{ sido: sidoCode },
												function (data, status) {
													$("#gugun").empty();
													$.each(data, function (index, vo) {
														$("#gugun").append(
															'<li data_code="' +
																vo.gugunCode +
																'" class="dropdown-item middle_area">' +
																vo.gugunName +
																"</li>"
														);
													}); // each
												}, // function
												"json"
											); // get
											
											// 동 설정 후 바로 목록 가져오기
											$.get(
													"/map/dong",
													{ gugun: gugunCode },
													function (data, status) {
														$("#dong").empty();
														$.each(data, function (index, vo) {
															$("#dong").append(
																'<li data_code="' +
																	vo.dongCode +
																	'" class="dropdown-item small_area">' +
																	vo.dongName +
																	"</li>"
															);
														}); // each
													}, // function
													"json"
												); // get

											onDisplay();
											makeSmallList(small_area_name, dongCode);
										}
								)						
					})
					
				})
			});
			
			
			function displayMarker(locPosition, idx) {
				imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
				imgOptions = {
					spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
					spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10), // 스프라이트
																			// 이미지
																			// 중
																			// 사용할
																			// 영역의
																			// 좌상단
																			// 좌표
					offset: new kakao.maps.Point(13, 37), // 마커 좌표에 일치시킬 이미지
															// 내에서의 좌표
				},
				markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
				marker = new kakao.maps.Marker({
					map : map,
					position: locPosition, // 마커의 위치
					image: markerImage,
				});

				markers.push(marker);
				marker.setMap(map);
			}
			
			function makeSmallList(sArea, sArea_code) {
				removeMarkers();
				smallInfos = []
				$("#aptInfo").empty();
				$("#aptInfo").append("<h1>검색 결과</h1>");
				
				$.get(
					"/map/apt",
					{ dong: sArea_code },
					function (data, status) {
						$.each(data, function (index, vo) {
							obj = {
								aptCode: vo.aptCode,
								aptName: vo.aptName,
								buildYear : vo.buildYear,
								dongCode: vo.dongCode,
								dongName: vo.dongName,
								jibun: vo.jibun,
								lat: vo.lat,
								lng: vo.lng,
							};
							smallInfos.push(obj);
							
							var apt =
								'<div class="aptDetailInfo" aptCode="' + vo.aptCode + '" data-bs-toggle="modal" data-bs-target="#dealInfoModal">' +
								"<h5>" +
								(index + 1) + ". " + vo.aptName +
								"</h5>" +
								"<div>건축 연도 : " + vo.buildYear + "</div>" + 
								"<div>위치 : " + vo.dongName + "</div></br>";

							$("#aptInfo").append(apt);
							var locPosition = new kakao.maps.LatLng(vo.lat, vo.lng); // 마커가
																						// 표시될
																						// 위치를
																						// geolocation으로
																						// 얻어온
																						// 좌표로
																						// 생성합니다

							displayMarker(locPosition, index);
							map.setCenter(locPosition);
						}); // each
					}, // function
					"json"
				); // get
			}

			function onDisplay() {
				$("#map").css("width", "70%");
				$("#aptInfo").css("display", "");
			}

			function offDisplay() {
				$("#map").css("width", "100%");
				$("#aptInfo").css("display", "none");
				$("#searchAptName").val("");
			}

			function removeMarkers() {
				for (let i = 0; i < markers.length; i++) {
					markers[i].setMap(null);
				}
				markers = [];
			}