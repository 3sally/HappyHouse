<template>
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
			<div>
				<div style="display:flex; justify-content:space-between">
					<div style="visibility:hidden;">
						<b-button>관심지역으로 조회</b-button>
					</div>
					<div>
						<input
							id="searchAptName"
							type="text"
							class="form-control-static"
							placeholder="지역구 내 아파트명"
							ref="searchWord"
						/>
						<b-button type="button" id="searchBtn" class="btn" @click="searchFunc">
							조회
						</b-button>
					</div>
					<div v-bind:style="{ visibility: userInfo ? '' : 'hidden' }">
						<b-button type="button" id="interestBtn" class="btn" @click="getInterest">
							관심지역으로 조회
						</b-button>
					</div>
				</div>
			</div>
			<hr />
		</div>
	</div>
</template>

<script>
import { mapState, mapActions, mapMutations } from "vuex";
import HouseMapSearchNotificationTemplate from "@/components/HouseMap/HouseMapSearchNotificationTemplate";

const houseStore = "houseStore";
const userStore = "userStore";

export default {
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
			"setSearchWord",
			"getInterestAreaInfo",
			"getOnlySido",
			"getCovidArea",
		]),
		searchFunc() {
			if (!this.sidoValue.value || !this.gugunValue.value || !this.dongValue.value) {
				this.notifyVue("top", "right");
				return;
			}
			this.setSearchWord(this.$refs.searchWord.value);
		},
		getInterest() {
			this.getInterestAreaInfo(this.userInfo);
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
		if (this.sidoValue.value || this.gugunValue.value || this.dongValue.value) {
			this.getOnlySido();
			console.log("이때는 변화없음");
		} else {
			this.getSido();
		}
		this.getCovidArea();
	},
};
</script>
<style>
.select-list .dropdown-menu {
	max-height: 400px;
	overflow-y: auto;
}
</style>
