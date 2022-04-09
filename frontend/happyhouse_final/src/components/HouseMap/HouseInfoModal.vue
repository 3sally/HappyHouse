<template>
	<b-modal id="house-detail" title="상세 정보">
		<h5 align="center">"{{ currentApt.aptName }}" 의 {{ detailInfo }} 확인</h5>
		<div align="center" style="display:flex; justify-content:space-between">
			<base-button @click="makeDealInfo" type="success">거래 정보</base-button>
			<base-button @click="makeRoadView" type="success">로드뷰</base-button>
		</div>
		<div id="container" style="width:100%; height:500px;">
			<h6 align="center" style="line-height:500px">원하는 버튼을 눌러주세요</h6>
		</div>
	</b-modal>
</template>

<script>
import { mapState } from "vuex";

let houseStore = "houseStore";
export default {
	computed: {
		...mapState(houseStore, ["currentApt", "currentAptDealInfo"]),
	},
	data() {
		return {
			detailInfo: "상세 정보",
		};
	},
	updated() {
		this.detailInfo = "상세 정보";
	},
	methods: {
		makeDealInfo() {
			this.detailInfo = "거래 정보";
			this.removeContainer();
			let roadviewContainer = document.getElementById("container");

			this.currentAptDealInfo.forEach((deal, idx) => {
				roadviewContainer.innerHTML += `
                    <div class="my-4">
                        <h5>현황 ${idx + 1}</h5>
                        <div>거래일자 : ${deal.dealYear}. ${deal.dealMonth}. ${deal.dealDay}</div>
                        <div>면적 : ${deal.area}</div>
                        <div>층 : ${deal.floor}</div>
                        <div>거래금액 : ${deal.dealAmount.trim()} (단위: 만원)</div><p />
                    </div>
                `;
			});
		},
		makeRoadView() {
			this.detailInfo = "로드뷰";
			this.removeContainer();
			let roadviewContainer = document.getElementById("container"); //로드뷰를 표시할 div

			let roadview = new kakao.maps.Roadview(roadviewContainer); //로드뷰 객체
			let roadviewClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체

			let position = new kakao.maps.LatLng(this.currentApt.lat, this.currentApt.lng);
			// 특정 위치의 좌표와 가까운 로드뷰의 panoId를 추출하여 로드뷰를 띄운다.
			roadviewClient.getNearestPanoId(position, 50, function(panoId) {
				roadview.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
			});
		},
		removeContainer() {
			const container = document.getElementById("container");
			while (container.hasChildNodes()) {
				container.removeChild(container.firstChild);
			}
			container.style.background = "";
			container.style.overflow = "scroll";
		},
	},
};
</script>
