<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        
        <title>Happy House</title>
        
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
        
        <!-- Kakao Map -->
        <script
            type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6da3606d86e0183669c5f2c966c24953&libraries=services"
        ></script>
        
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${root}/css/styles.css" rel="stylesheet" />
        
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="/">Happy House</a>
                <button
                    class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarResponsive"
                    aria-controls="navbarResponsive"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
                >
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                
                    <ul class="navbar-nav ms-auto">
                    <c:if test="${!empty userinfo}">
                    <strong>${userinfo.userName}</strong> (${userinfo.userId})님 안녕하세요.
                      <li class="nav-item mx-0 mx-lg-1">
                          <a class="nav-link py-3 px-0 px-lg-3 rounded" href="${root}/article/list">공지사항</a>
                      </li>
                      <li class="after-login nav-item mx-0 mx-lg-1">
                        <a class="nav-link py-3 px-0 px-lg-3 rounded" href="${root}/user/mypage">마이페이지</a>
                      </li>
                      <li class="after-login nav-item mx-0 mx-lg-1">
                        <a class="nav-link py-3 px-0 px-lg-3 rounded" href="#">찜♥</a>
                      </li>
                       
                        <li class="after-login nav-item mx-0 mx-lg-1">
                            <a class="nav-link py-3 px-0 px-lg-3 rounded" href="${root}/user/logout"
                                >로그아웃</a
                            >
                        </li>
                        </c:if>
                        <c:if test="${empty userinfo}">
                         <li class="before-login nav-item mx-0 mx-lg-1">
                            <a class="nav-link py-3 px-0 px-lg-3 rounded" href="#login-modal" data-toggle="modal"
                                >로그인</a
                            >
                        </li>
                        <li class="before-login nav-item mx-0 mx-lg-1">
                            <a class="nav-link py-3 px-0 px-lg-3 rounded" href="#signup-modal" data-toggle="modal"
                                >회원가입</a
                            >
                        </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Masthead-->
        <header class="masthead-mypage bg-primary text-white text-center">
        </header>
