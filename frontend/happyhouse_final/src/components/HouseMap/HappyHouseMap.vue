<template>
  <div class="row">
    <div v-if="checkDisplay" style="width: 25%; height:700px; overflow: auto;">
      <div class="dropdown" align="right">
        <div class="btn-group">
          <b-dropdown class="select-list" :text="keyword">
            <b-dropdown-item
              v-for="(keyword, index) in sortKeywords"
              v-bind:key="index"
              @click="sortByKeyword(keyword)"
              >{{ keyword }}</b-dropdown-item
            >
          </b-dropdown>
        </div>
      </div>
      <br />
      <h2 align="center">검색 결과</h2>
      <br />
      <div v-if="aptList.length >= 0">
        <div
          v-for="(apt, idx) in (searchList = aptList.filter((v) =>
            v.aptName.includes(searchWord)
          ))"
          :key="apt.aptCode"
        >
          <div
            v-b-modal.house-detail
            @click="getAptDealInfo(apt), changeCurrentApt(apt), setCenter(apt)"
            @mouseover="openWindow(idx)"
            @mouseout="closeWindow(idx)"
          >
            <h5>{{ idx + 1 }}. {{ apt.aptName }}</h5>
            <div>건축 연도 : {{ apt.buildYear }}</div>
            <div>위치 : {{ apt.dongName }}</div>
            <br />
          </div>
        </div>
      </div>
      <div v-else>검색 결과가 없습니다.</div>
    </div>
    <!-- 지도 -->
    <div
      id="map"
      v-bind:style="{ width: checkDisplay ? '75%' : '100%', height: '700px' }"
    >
      <div class="map_wrap">
        <ul id="category">
          <li id="BK9" data-order="0">
            <span class="category_bg bank"
              ><img
                src="https://i.ibb.co/JcPgJcw/3319599-cois-dollar-investment-money-icon.png"
            /></span>
            은행
          </li>
          <li id="MT1" data-order="1">
            <span class="category_bg mart"
              ><img
                src="https://i.ibb.co/qpxkrcQ/1055098-cart-basket-shopping-icon.png"
            /></span>
            마트
          </li>
          <li id="PM9" data-order="2">
            <span class="category_bg pharmacy"
              ><img
                src="https://i.ibb.co/CWrBtPJ/6673745-health-healthcare-hospital-medic-medical-icon.png"
            /></span>
            약국
          </li>
          <li id="OL7" data-order="3">
            <span class="category_bg oil"
              ><img
                src="https://i.ibb.co/1rTmHv5/1055052-gas-fuel-gasoline-oil-petrol-icon.png"
            /></span>
            주유소
          </li>
          <li id="CE7" data-order="4">
            <span class="category_bg cafe"
              ><img
                src="https://i.ibb.co/XFMcst7/3535188-cafe-coffee-cup-drink-fresh-icon.png"
            /></span>
            카페
          </li>
          <li id="CS2" data-order="5">
            <span class="category_bg store"
              ><img src="https://i.ibb.co/qYHzJs5/24-hours.png"
            /></span>
            편의점
          </li>
          <li v-if="!showCovid" @click="showCovidMarkers">
            <span
              ><img
                src="https://i.ibb.co/mXkLwqZ/7847504-virus-dissease-covid-icon.png"
            /></span>
            코로나
          </li>
          <li v-else @click="hideCovidMarkers">
            <span
              ><img
                src="https://i.ibb.co/mXkLwqZ/7847504-virus-dissease-covid-icon.png"
            /></span>
            코로나
          </li>
        </ul>
      </div>
    </div>

    <!-- 모달 -->
    <house-info-modal />
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import HouseInfoModal from "@/components/HouseMap/HouseInfoModal.vue";
import HouseMapSearchNotificationTemplate from "@/components/HouseMap/HouseMapSearchNotificationTemplate";

let houseStore = "houseStore";
let userStore = "userStore";

export default {
  name: "KakaoMap",
  data() {
    return {
      // imageSrc: "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png",
      // imageSrc: "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png",
      imageSrc: "https://i.ibb.co/5TQyJgM/118770-home-icon.png",
      map: null,
      markers: [],

      searchList: [],
      infowindows: [],

      imgPaths: [
        require("@/assets/houseImgs/sample_apt_img_1.png"),
        require("@/assets/houseImgs/sample_apt_img_2.png"),
        require("@/assets/houseImgs/sample_apt_img_3.png"),
        require("@/assets/houseImgs/sample_apt_img_4.png"),
        require("@/assets/houseImgs/sample_apt_img_5.png"),
      ],

      keyword: "정렬 기준 선택",
      sortKeywords: [
        "낮은 가격순",
        "높은 가격순",
        "거래 많은순",
        "거래 적은순",
      ],

      categoryMarkers: [],
      currCategory: "",
      categoryImgPaths: [
        "https://i.ibb.co/JcPgJcw/3319599-cois-dollar-investment-money-icon.png",
        "https://i.ibb.co/qpxkrcQ/1055098-cart-basket-shopping-icon.png",
        "https://i.ibb.co/CWrBtPJ/6673745-health-healthcare-hospital-medic-medical-icon.png",
        "https://i.ibb.co/1rTmHv5/1055052-gas-fuel-gasoline-oil-petrol-icon.png",
        "https://i.ibb.co/XFMcst7/3535188-cafe-coffee-cup-drink-fresh-icon.png",
        "https://i.ibb.co/qYHzJs5/24-hours.png",
      ],

      covidMarkers: [],
      showCovid: false,
    };
  },
  components: {
    HouseInfoModal,
  },
  mounted() {
    this.removeMarkers();

    if (window.kakao && window.kakao.maps) {
      this.initMap();
    } else {
      let script = document.createElement("script");
      /* global kakao */
      script.onload = () => kakao.maps.load(this.initMap);
      script.src =
        "http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=af4dad08121682d6df3a5312e9e778bc&libraries=services";
      document.head.appendChild(script);
    }
    this.relatedCategory();
    this.makeCovidMarkers();
    this.hideCovidMarkers();
  },
  watch: {
    searchList: function(data) {
      if (!data.length) return;

      this.removeMarkers();

      data.forEach((apt, idx) => {
        let locPosition = new kakao.maps.LatLng(apt.lat, apt.lng);

        this.displayMarker(locPosition, idx);
        this.map.setCenter(locPosition);
      });
    },
    dongValue: function(o, n) {
      if (o.text !== n.text) this.keyword = "정렬 기준 선택";
    },
    gugunValue: function(o, n) {
      if (o.text !== n.text) this.hideCovidMarkers();
    },
  },
  computed: {
    ...mapState(houseStore, [
      "sidoValue",
      "gugunValue",
      "dongValue",
      "aptList",
      "checkDisplay",
      "currentApt",
      "searchWord",
      "currentAptDealInfo",
      "covidList",
    ]),
    ...mapState(userStore, ["userInfo"]),
  },
  methods: {
    ...mapActions(houseStore, [
      "getAptDealInfo",
      "changeCurrentApt",
      "clearAllStates",
    ]),
    initMap() {
      const container = document.getElementById("map");
      // 마커가 표시될 위치입니다
      let locPosition = new kakao.maps.LatLng(33.450701, 126.570667);

      const options = {
        center: locPosition,
        level: 4,
      };

      this.map = new kakao.maps.Map(container, options);
      this.removeMarkers();
      // 마커가 지도 위에 표시되도록 설정합니다 -> dongValue 없을때만
      if (!this.dongValue.value) {
        if (navigator.geolocation) {
          // GeoLocation을 이용해서 접속 위치를 얻어옵니다
          navigator.geolocation.getCurrentPosition((position) => {
            let lat = position.coords.latitude, // 위도
              lon = position.coords.longitude; // 경도

            locPosition = new kakao.maps.LatLng(lat, lon);

            this.displayMarker(locPosition, 0);
            this.map.setCenter(locPosition);
          });
        } else {
          this.displayMarker(locPosition, 0);
          this.map.setCenter(locPosition);
        }
      }
      this.relatedCategory();
    },

    displayMarker(locPosition, idx) {
      const imageSize = new kakao.maps.Size(31, 35); // 마커 이미지의 크기
      const markerImage = new kakao.maps.MarkerImage(this.imageSrc, imageSize);
      let marker = new kakao.maps.Marker({
        map: this.map,
        position: locPosition, // 마커의 위치
        image: markerImage,
      });
      this.markers.push(marker);
      marker.setMap(this.map);
      this.addMarkerMouseEvent(this.map, marker, idx);
    },

    removeMarkers() {
      this.markers.forEach((marker) => marker.setMap(null));
      this.markers = [];
      this.infowindows = [];
    },

    setCenter(apt) {
      let locPosition = new kakao.maps.LatLng(apt.lat, apt.lng);
      this.map.setCenter(locPosition);
    },

    addMarkerMouseEvent(map, marker, idx) {
      // 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
      const curApt = { ...this.searchList[idx] };
      const iwContent =
        this.searchList.length > 0
          ? `<div style="padding:5px;">
                            <div>
								<img src="${
                  this.imgPaths[idx % 5]
                }" style="width:250px; height:250px" alt="No Image"/>
							</div>
							<br />
                            <h5 align="center">${idx + 1}. ${
              curApt.aptName
            }</h5>
							<h6>건축 연도 : ${curApt.buildYear}</h6>
							<h6>위치 : ${curApt.dongName}</h6>
							<h6>평균 거래가 : ${("" + curApt.avgDealAmount).replace(
                /(\d)(?=(?:\d{3})+(?!\d))/g,
                "$1,"
              )} (단위: 만원)</h6>
							<h6>거래 횟수 : ${curApt.totalDealCount}</h6>
                        </div>`
          : `<div style="padding:5px">
                            <h5 align="center">현재 위치</h5>
                        </div>`;
      // 인포윈도우를 생성합니다
      const infowindow = new kakao.maps.InfoWindow({
        content: iwContent,
      });

      this.infowindows.push(infowindow);

      kakao.maps.event.addListener(marker, "mouseover", function() {
        // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
        infowindow.open(map, marker);
      });

      // 마커에 마우스아웃 이벤트를 등록합니다
      kakao.maps.event.addListener(marker, "mouseout", function() {
        // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
        infowindow.close();
      });
    },

    openWindow(idx) {
      this.infowindows[idx].open(this.map, this.markers[idx]);
    },
    closeWindow(idx) {
      this.infowindows[idx].close();
    },
    sortByKeyword(keyword) {
      this.keyword = keyword;
      switch (this.keyword) {
        case "낮은 가격순":
          this.aptList.sort((a, b) => a.avgDealAmount - b.avgDealAmount);
          break;
        case "높은 가격순":
          this.aptList.sort((a, b) => b.avgDealAmount - a.avgDealAmount);
          break;
        case "거래 많은순":
          this.aptList.sort((a, b) => b.totalDealCount - a.totalDealCount);
          break;
        case "거래 적은순":
          this.aptList.sort((a, b) => a.totalDealCount - b.totalDealCount);
          break;
      }
    },
    relatedCategory() {
      const This = this;
      const placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 });
      const contentNode = document.createElement("div");

      const ps = new kakao.maps.services.Places(this.map);
      kakao.maps.event.addListener(this.map, "idle", searchPlaces);

      // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다
      contentNode.className = "placeinfo_wrap";
      // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
      // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다
      addEventHandle(contentNode, "mousedown", kakao.maps.event.preventMap);
      addEventHandle(contentNode, "touchstart", kakao.maps.event.preventMap);

      // 커스텀 오버레이 컨텐츠를 설정합니다
      placeOverlay.setContent(contentNode);

      // 각 카테고리에 클릭 이벤트를 등록합니다
      addCategoryClickEvent();

      // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
      function addEventHandle(target, type, callback) {
        if (target.addEventListener) {
          target.addEventListener(type, callback);
        } else {
          target.attachEvent("on" + type, callback);
        }
      }

      // 카테고리 검색을 요청하는 함수입니다
      function searchPlaces() {
        if (!This.currCategory) {
          return;
        }
        // 커스텀 오버레이를 숨깁니다
        placeOverlay.setMap(null);

        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();

        ps.categorySearch(This.currCategory, placesSearchCB, {
          useMapBounds: true,
        });
      }

      // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
      function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
          // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
          displayPlaces(data);
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
          // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
        } else if (status === kakao.maps.services.Status.ERROR) {
          // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
        }
      }

      // 지도에 마커를 표출하는 함수입니다
      function displayPlaces(places) {
        // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
        // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
        let order = document
          .getElementById(This.currCategory)
          .getAttribute("data-order");

        for (let i = 0; i < places.length; i++) {
          // 마커를 생성하고 지도에 표시합니다
          let marker = addMarker(
            new kakao.maps.LatLng(places[i].y, places[i].x),
            order
          );

          // 마커와 검색결과 항목을 클릭 했을 때
          // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
          (function(marker, place) {
            kakao.maps.event.addListener(marker, "click", function() {
              displayPlaceInfo(place);
            });
          })(marker, places[i]);
        }
      }
      // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
      function addMarker(position, order) {
        let imageSrc =
            "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
          imageSize = new kakao.maps.Size(27, 28), // 마커 이미지의 크기
          // imgOptions = {
          // 	spriteSize: new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
          // 	spriteOrigin: new kakao.maps.Point(46, order * 36), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
          // 	offset: new kakao.maps.Point(11, 28), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
          // },
          markerImage = new kakao.maps.MarkerImage(
            This.categoryImgPaths[order],
            imageSize
          ),
          marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage,
          });

        marker.setMap(This.map); // 지도 위에 마커를 표출합니다
        This.categoryMarkers.push(marker); // 배열에 생성된 마커를 추가합니다

        return marker;
      }

      // 지도 위에 표시되고 있는 마커를 모두 제거합니다
      function removeMarker() {
        for (let i = 0; i < This.categoryMarkers.length; i++) {
          This.categoryMarkers[i].setMap(null);
        }
        This.categoryMarkers = [];
      }

      // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
      function displayPlaceInfo(place) {
        let content =
          '<div class="placeinfo">' +
          '   <a class="title" href="' +
          place.place_url +
          '" target="_blank" title="' +
          place.place_name +
          '">' +
          place.place_name +
          "</a>";

        if (place.road_address_name) {
          content +=
            '    <span title="' +
            place.road_address_name +
            '">' +
            place.road_address_name +
            "</span>" +
            '  <span class="jibun" title="' +
            place.address_name +
            '">(지번 : ' +
            place.address_name +
            ")</span>";
        } else {
          content +=
            '    <span title="' +
            place.address_name +
            '">' +
            place.address_name +
            "</span>";
        }

        content +=
          '    <span class="tel">' +
          place.phone +
          "</span>" +
          "</div>" +
          '<div class="after"></div>';

        console.log(place);
        contentNode.innerHTML = content;
        placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
        placeOverlay.setMap(This.map);
      }

      // 각 카테고리에 클릭 이벤트를 등록합니다
      function addCategoryClickEvent() {
        let category = document.getElementById("category"),
          children = category.children;

        for (let i = 0; i < children.length; i++) {
          children[i].onclick = onClickCategory;
        }
      }

      // 카테고리를 클릭했을 때 호출되는 함수입니다
      function onClickCategory() {
        let id = this.id,
          className = this.className;
        placeOverlay.setMap(null);

        if (className === "on") {
          This.currCategory = "";
          changeCategoryClass();
          removeMarker();
        } else {
          This.currCategory = id;
          changeCategoryClass(this);
          searchPlaces();
        }
      }

      // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
      function changeCategoryClass(el) {
        let category = document.getElementById("category"),
          children = category.children,
          i;

        for (i = 0; i < children.length; i++) {
          children[i].className = "";
        }

        if (el) {
          el.className = "on";
        }
      }
    },
    makeCovidMarkers() {
      const imageSize = new kakao.maps.Size(35, 35); // 마커 이미지의 크기
      const markerImage = new kakao.maps.MarkerImage(
        "https://i.ibb.co/mXkLwqZ/7847504-virus-dissease-covid-icon.png",
        imageSize
      );
      console.log("makemakemake");
      this.covidList.forEach((area) => {
        let marker = new kakao.maps.Marker({
          map: this.map,
          position: new kakao.maps.LatLng(area.lat, area.lng), // 마커의 위치
          image: markerImage,
        });
        this.covidMarkers.push(marker);
        this.addCovidMarkerEvent(this.map, marker, area);
      });
    },
    showCovidMarkers() {
      if (
        !this.sidoValue.value ||
        !this.gugunValue.value ||
        !this.dongValue.value
      ) {
        this.notifyVue("top", "right");
        return;
      }
      this.showCovid = true;
      console.log("showshowshow");
      console.log(this.covidMarkers);
      this.covidMarkers.forEach((area, idx) => {
        console.log(area);
        if (
          this.covidList[idx].gugunCode.substring(0, 5) ===
          this.gugunValue.value.substring(0, 5)
        ) {
          area.setMap(this.map);
          console.log(area);
        }
      });
    },
    hideCovidMarkers() {
      this.showCovid = false;
      console.log("hidehidehide");
      this.covidMarkers.forEach((area) => area.setMap(null));
    },
    addCovidMarkerEvent(map, marker, areainfo) {
      const iwContent = `<div style="padding:5px; width:260px">
							<br />
                            <h5 align="center">${areainfo.gigwanName}</h5>
							<h6>주소 : ${areainfo.gigwanAddress}</h6>
							<h6 align="center">운영시간</h6>
							<div>평일 : ${areainfo.weekdayTime}</div>
							<div>토요일 : ${areainfo.saturdayTime}</div>
							<div>일요일 : ${areainfo.sundayTime}</div>
							<h6 align="center">정보</h6>
							<div>${areainfo.info ? areainfo.info : "없음"}</div>
                        </div>`;
      // 인포윈도우를 생성합니다
      const infowindow = new kakao.maps.InfoWindow({
        content: iwContent,
      });

      kakao.maps.event.addListener(marker, "mouseover", function() {
        // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
        infowindow.open(map, marker);
      });

      // 마커에 마우스아웃 이벤트를 등록합니다
      kakao.maps.event.addListener(marker, "mouseout", function() {
        // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
        infowindow.close();
      });
    },
    notifyVue(verticalAlign, horizontalAlign) {
      this.$notify({
        component: HouseMapSearchNotificationTemplate,
        icon: "tim-icons icon-bell-55",
        horizontalAlign: horizontalAlign,
        verticalAlign: verticalAlign,
        type: "primary",
        timeout: 0,
      });
    },
  },
};
</script>

<style>
.map_wrap,
.map_wrap * {
  margin: 0;
  padding: 0;
  font-family: "Malgun Gothic", dotum, "돋움", sans-serif;
  font-size: 12px;
}
.map_wrap {
  position: relative;
  width: 100%;
  height: 350px;
}
#category {
  margin: 0;
  position: absolute;
  top: 10px;
  left: 10px;
  border-radius: 5px;
  border: 1px solid #909090;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
  background: #fff;
  overflow: hidden;
  z-index: 2;
}
#category li {
  margin: 0;
  float: left;
  list-style: none;
  width: 50px;
  border-right: 1px solid #acacac;
  padding: 6px 0;
  text-align: center;
  cursor: pointer;
}
#category li.on {
  background: #eee;
}
#category li:hover {
  background: #ffe6e6;
  border-left: 1px solid #acacac;
  margin-left: -1px;
}
#category li:last-child {
  margin-right: 0;
  border-right: 0;
}
#category li span {
  display: block;
  margin: 0 auto 3px;
  width: 27px;
  height: 28px;
}
/* #category li .category_bg {
	background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png)
		no-repeat;
} */
/* #category li .bank {
	background: url(https://i.ibb.co/JcPgJcw/3319599-cois-dollar-investment-money-icon.png);
} */
/* #category li .mart {
	background-position: -10px -36px;
}
#category li .pharmacy {
	background-position: -10px -72px;
}
#category li .oil {
	background-position: -10px -108px;
}
#category li .cafe {
	background-position: -10px -144px;
}
#category li .store {
	background-position: -10px -180px;
}
#category li.on .category_bg {
	background-position-x: -46px;
} */
.placeinfo_wrap {
  position: absolute;
  bottom: 28px;
  left: -150px;
  width: 300px;
}
.placeinfo {
  position: relative;
  width: 100%;
  border-radius: 6px;
  border: 1px solid #ccc;
  border-bottom: 2px solid #ddd;
  padding-bottom: 10px;
  background: #fff;
}
.placeinfo:nth-of-type(n) {
  border: 0;
  box-shadow: 0px 1px 2px #888;
}
.placeinfo_wrap .after {
  content: "";
  position: relative;
  margin-left: -12px;
  left: 50%;
  width: 22px;
  height: 12px;
  background: url("https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png");
}
.placeinfo a,
.placeinfo a:hover,
.placeinfo a:active {
  color: #fff;
  text-decoration: none;
}
.placeinfo a,
.placeinfo span {
  display: block;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}
.placeinfo span {
  margin: 5px 5px 0 5px;
  cursor: default;
  font-size: 13px;
}
.placeinfo .title {
  font-weight: bold;
  font-size: 14px;
  border-radius: 6px 6px 0 0;
  margin: -1px -1px 0 -1px;
  padding: 10px;
  color: #fff;
  background: #d95050;
  background: #d95050
    url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
    no-repeat right 14px center;
}
.placeinfo .tel {
  color: #0f7833;
}
.placeinfo .jibun {
  color: #999;
  font-size: 11px;
  margin-top: 0;
}
</style>
