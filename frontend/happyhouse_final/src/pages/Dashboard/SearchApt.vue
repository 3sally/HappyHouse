<template>
	<div class="content">
		<div class="row">
			<div class="col-12">
				<card>
					<div align="center">
						<!-- 지도 셀렉트 바 -->
						<br />
						<div>
							<div class="dropdown">
								<div class="btn-group">
									<b-dropdown class="select-list" variant="success" :text="sidoValue.text">
										<b-dropdown-item
											v-for="(sido, index) in sidoList"
											v-bind:key="index"
											@click="setSidoValue(sido), getGuGun(sido)"
											>{{ sido.text }}</b-dropdown-item
										>
									</b-dropdown>
								</div>
								&nbsp;&nbsp;
								<div class="btn-group">
									<b-dropdown class="select-list" variant="success" :text="gugunValue.text">
										<b-dropdown-item
											v-for="(gugun, index) in gugunList"
											v-bind:key="index"
											@click="setGuGunValue(gugun), getDong(gugun)"
											>{{ gugun.text }}</b-dropdown-item
										>
									</b-dropdown>
								</div>
								&nbsp;&nbsp;
								<div class="btn-group">
									<b-dropdown class="select-list" variant="success" :text="dongValue.text">
										<b-dropdown-item
											v-for="(dong, index) in dongList"
											v-bind:key="index"
											@click="setDongValue(dong), getApt(dong)"
											>{{ dong.text }}</b-dropdown-item
										>
									</b-dropdown>
								</div>
							</div>
							<div class="float-right">
								<div style="display:flex; ">
									<div>
										<b-button type="button" id="searchBtn" class="btn" @click="searchFunc">
											선택한 지역으로 조회
										</b-button>
									</div>
									<div v-if="userInfo">
										<b-button type="button" id="interestBtn" class="btn" @click="getInterest">
											관심지역으로 조회
										</b-button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</card>
			</div>
		</div>
	</div>
</template>
<script>
import { Card } from "@/components/index";

import { mapState, mapActions } from "vuex";
import HouseMapSearchNotificationTemplate from "@/components/HouseMap/HouseMapSearchNotificationTemplate";

const houseStore = "houseStore";
const userStore = "userStore";

export default {
	components: {
		Card,
	},
	computed: {
		...mapState(houseStore, [
			"sidoList",
			"sidoValue",
			"gugunList",
			"gugunValue",
			"dongList",
			"dongValue",
			"aptList",
		]),
		...mapState(userStore, ["userInfo"]),
	},
	methods: {
		...mapActions(houseStore, [
			"getSido",
			"setSidoValue",
			"getGuGun",
			"setGuGunValue",
			"getDong",
			"setDongValue",
			"getApt",
			"getInterestAreaInfo",
		]),
		searchFunc() {
			if (!this.sidoValue.value || !this.gugunValue.value || !this.dongValue.value) {
				this.notifyVue("top", "right");
				return;
			}
			this.$router.push({ name: "Maps" });
		},
		getInterest() {
			this.getInterestAreaInfo(this.userInfo);
			this.setDongValue({ value: "1", text: "동 선택" });
			this.$router.push({ name: "Maps" });
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
	created() {
		this.getSido();
	},
};
</script>
<style>
.select-list .dropdown-menu {
	max-height: 400px;
	overflow-y: auto;
}
</style>
