# HAPPY HOUSE 🏡

[삼성 청년 SW 아카데미 1학기 관통 프로젝트]

### ✨ 서울의 아파트 거래 내역과 그 주변 상권 정보를 제공해주는 웹 서비스 ✨

---

## **📎  프로젝트 목차**

---

- [1️⃣  프로젝트 소개](#1️⃣-프로젝트-소개)
- [2️⃣  기술 스택](#2️⃣-기술-스택)
- [3️⃣  파일 구조](#3️⃣-파일-구조)
- [4️⃣  산출물](#4️⃣-산출물)

---

### 1️⃣ 프로젝트 소개

📆  일정 : 20.11.18 - 22.11.25 (총 8일)
- - - - - - - - - - - - - - - - - - - - - 

👨‍👨‍👦‍  인원 (총 2인)

    🧑  장동재 : 팀장, 카카오 지도 API와 공공데이터를 활용한 지도 관련 기능 Frontend & Backend 담당

    👩  이민정 : 공지사항, Q&A게시판, 회원관리(로그인, 회원가입, 마이페이지) Frontend & Backend 담당 

---

### 2️⃣ 기술 스택

1. 형상관리 : Gitlab
2. 개발 환경
    - OS
        - Mac
    - IDE
        - Eclipse
        - Visual Studio Code
    - Frontend
        - Vue
        - Vuex
    - Backend
        - Java
        - SpringBoot
        - MyBatis
    - Database
        - MySQL Workbench

---

### 3️⃣ 파일 구조

- Back
    
    ```powershell
    .
    └── com
        └── ssafy
            ├── happyhouse
            │   └── exception
            ├── happyhouseproject
            │   ├── aop
            │   ├── config
            │   ├── controller
            │   ├── interceptor
            │   └── model
            │       ├── mapper
            │       └── service
            └── util
    ```
    
- Front
    
    ```powershell
    .
    ├── public
    └── src
        ├── api
        ├── assets
        │   ├── css
        │   ├── demo
        │   ├── fonts
        │   ├── houseImgs
        │   ├── img
        │   └── scss
        │       └── white-dashboard
        │           ├── bootstrap
        │           │   ├── mixins
        │           │   └── utilities
        │           ├── custom
        │           │   ├── cards
        │           │   ├── mixins
        │           │   ├── utilities
        │           │   └── vendor
        │           └── plugins
        ├── components
        │   ├── Cards
        │   ├── Charts
        │   ├── HouseMap
        │   ├── Inputs
        │   ├── NotificationPlugin
        │   ├── QnA
        │   │   └── comment
        │   ├── SidebarPlugin
        │   ├── notice
        │   └── user
        ├── config
        ├── locales
        ├── pages
        │   ├── Dashboard
        │   ├── Layout
        │   ├── Notifications
        │   └── Profile
        ├── store
        │   └── modules
        └── util 
    ```
    

---

### 4️⃣ 산출물

- [발표 ppt](https://github.com/3sally/HappyHouse/tree/main/%EC%82%B0%EC%B6%9C%EB%AC%BC/erd)
- [erd](https://github.com/3sally/HappyHouse/tree/main/%EC%82%B0%EC%B6%9C%EB%AC%BC/%EB%B0%9C%ED%91%9Cppt)
