<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>

$(document).ready(function () {
	var tbody = "";
	var aptname = "";
	var address = "";
	var buildyear = "";
	
	<c:forEach var="dealDetailInfo" items="${dealsDetailInfo}">
		<c:if test="${dealDetailInfo.aptCode eq param.aptcode}">
			tbody += "<tr>";
			tbody += "	<td>${dealDetailInfo.dealAmount}</td>";
			tbody += "	<td>${dealDetailInfo.area}</td>";
			tbody += "	<td>${dealDetailInfo.floor}</td>";
			tbody += "</tr>";
			
			aptname = "${dealDetailInfo.houseInfo.aptName}";
			address = "${dealDetailInfo.houseInfo.dongName} ${dealDetailInfo.houseInfo.roadName} ${dealDetailInfo.houseInfo.roadCode}";
			buildyear = "건축년도 : ${dealDetailInfo.houseInfo.buildYear}";
		</c:if>
	</c:forEach>
	
	console.log(tbody);
	$("#tbody").html(tbody);
	$("#aptname").text(aptname);
	$("#address").text(address);
	$("#buildyear").text(buildyear);
});

</script>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        
        <title>Happy House Detail</title>
        
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="img/home-solid.svg" />
        
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        
        <!-- Font Awesome icons (free version)-->
        <script
            src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
            crossorigin="anonymous"
        ></script>
        
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link
            href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
            rel="stylesheet"
            type="text/css"
        />
        
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
        
    </head>
    <body>
        <div class="container mt-5 mb-5 text-center">
            <h2 class="page-section-heading text-center text-uppercase text-secondary">아파트별 상세거래정보</h2>
            <div class="divider-custom">
	            <div class="divider-custom-line"></div>
	        </div>
	        
	        <p id="aptname" class="masthead-subheading font-weight-bold mt-1 mb-3"></p>
	        <p id="address" class="masthead-subheading font-weight-medium mt-1 mb-3"></p>
	        <p id="buildyear" class="masthead-subheading font-weight-light mt-1 mb-3"></p>

            <div class="row justify-content-center mt-3">
                <div class="mb-5 text-center">
                    <div style="width: 100%; height: 800px; overflow: auto">
                        <table class="table text-center">
                            <thead>
                                <tr>
                                    <th>거래금액</th>
                                    <th>전용면적</th>
                                    <th>층</th>
                                </tr>
                            </thead>
                            <tbody id="tbody"></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
