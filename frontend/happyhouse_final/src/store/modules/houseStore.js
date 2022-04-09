import http from "@/util/http-common.js";

const houseStore = {
	namespaced: true,
	state: {
		sidoList: [],
		sidoValue: {},

		gugunList: [],
		gugunValue: {},

		dongList: [],
		dongValue: {},

		aptList: [],

		searchWord: "",

		// map: null,
		// markers: [],
		checkDisplay: false,
		currentApt: {},

		currentAptDealInfo: [],

		covidList: [],
	},
	mutations: {
		/* 시도 관련  */
		SET_SIDO_LIST: (state, sidoList) => {
			sidoList.forEach((sido) =>
				state.sidoList.push({ value: sido.sidoCode, text: sido.sidoName })
			);
		},
		SET_SIDO_VALUE: (state, sidoValue) => {
			state.sidoValue = sidoValue;
		},
		INITIAL_SIDO_LIST: (state) => {
			state.sidoList = [];
			state.sidoValue = { value: null, text: "시/도 선택" };
		},

		/* 구군 관련 */
		SET_GUGUN_LIST: (state, gugunList) => {
			gugunList.forEach((gugun) =>
				state.gugunList.push({ value: gugun.gugunCode, text: gugun.gugunName })
			);
		},
		SET_GUGUN_VALUE: (state, gugunValue) => {
			state.gugunValue = gugunValue;
		},
		INITIAL_GUGUN_LIST: (state) => {
			state.gugunList = [];
			state.gugunValue = { value: null, text: "구/군 선택" };
		},

		/* 동 관련*/
		SET_DONG_LIST: (state, dongList) => {
			dongList.forEach((dong) =>
				state.dongList.push({ value: dong.dongCode, text: dong.dongName })
			);
		},
		SET_DONG_VALUE: (state, dongValue) => {
			state.dongValue = dongValue;
		},
		INITIAL_DONG_LIST: (state) => {
			state.dongList = [];
			state.dongValue = { value: null, text: "동/선택" };
		},

		/* 아파트 관련 */
		SET_APT_LIST: (state, aptList) => {
			aptList.forEach((apt) => state.aptList.push(apt));
		},
		INITIAL_APT_LIST: (state) => {
			state.aptList = [];
		},

		/* 거래 정보 관련 */
		SET_CURRENT_APT_DEAL_INFO: (state, currentAptDealInfo) => {
			currentAptDealInfo.forEach((deal) => state.currentAptDealInfo.push(deal));
		},
		INITIAL_CURRENT_APT_DEAL_INFO: (state) => {
			state.currentAptDealInfo = [];
		},

		/* 마커 관련 */
		// PUSH_MARKER: (state, marker) => {
		// 	state.markers.push(marker);
		// },
		// INITIAL_MARKER_LIST: (state) => {
		// 	state.markers = [];
		// },

		ON_CHECK_DISPLAY: (state) => {
			state.checkDisplay = true;
		},
		OFF_CHECK_DISPLAY: (state) => {
			state.checkDisplay = false;
		},

		CHANGE_CURRENT_APT: (state, currentApt) => {
			state.currentApt = currentApt;
		},

		INITIAL_SEARCH_WORD: (state) => {
			state.searchWord = "";
		},

		SET_SEARCH_WORD: (state, word) => {
			if (word.length === 0) word = "";
			state.searchWord = word;
		},

		SET_COVID_LIST: (state, covidList) => {
			covidList.forEach((covid) => state.covidList.push(covid));
		},

		INITIAL_COVID_LIST: (state) => {
			state.covidList = [];
		},
	},
	actions: {
		getSido({ commit }) {
			http
				.get("/map/sido")
				.then((response) => {
					commit("INITIAL_SIDO_LIST");
					commit("INITIAL_GUGUN_LIST");
					commit("INITIAL_DONG_LIST");
					commit("INITIAL_APT_LIST");
					commit("OFF_CHECK_DISPLAY");

					commit("SET_SIDO_LIST", response.data);
				})
				.catch((error) => {
					console.log(error);
				});
		},
		setSidoValue({ commit }, sidoValue) {
			commit("SET_SIDO_VALUE", sidoValue);
		},

		getGuGun({ commit }, sidoValue) {
			const params = {
				sido: sidoValue.value,
			};
			http
				.get("/map/gugun", { params })
				.then((response) => {
					commit("INITIAL_GUGUN_LIST");
					commit("INITIAL_DONG_LIST");
					commit("INITIAL_APT_LIST");
					commit("OFF_CHECK_DISPLAY");

					commit("SET_GUGUN_LIST", response.data);
				})
				.catch((error) => console.log(error));
		},
		setGuGunValue({ commit }, gugunValue) {
			commit("SET_GUGUN_VALUE", gugunValue);
		},

		getDong({ commit }, gugunValue) {
			const params = {
				gugun: gugunValue.value,
			};

			http
				.get("/map/dong", { params })
				.then((response) => {
					commit("INITIAL_DONG_LIST");
					commit("INITIAL_APT_LIST");
					commit("OFF_CHECK_DISPLAY");

					commit("SET_DONG_LIST", response.data);
				})
				.catch((error) => console.log(error));
		},
		setDongValue({ commit }, dongValue) {
			commit("SET_DONG_VALUE", dongValue);
		},

		getApt({ commit }, dongValue) {
			const params = {
				dong: dongValue.value,
			};

			http
				.get("/map/apt", { params })
				.then((response) => {
					console.log(response.data);
					commit("INITIAL_APT_LIST");
					// commit("INITIAL_MARKER_LIST");
					commit("SET_APT_LIST", response.data);
					commit("ON_CHECK_DISPLAY");
				})
				.catch((error) => console.log(error));
		},

		async getAptDealInfo({ commit }, currentApt) {
			const params = {
				aptCode: currentApt.aptCode,
			};

			try {
				const response = await http.get("/map/deal", { params });
				commit("INITIAL_CURRENT_APT_DEAL_INFO");
				commit("SET_CURRENT_APT_DEAL_INFO", response.data);
			} catch (error) {
				console.log(error);
			}
		},

		setSearchWord({ commit }, word) {
			commit("SET_SEARCH_WORD", word);
		},

		changeCurrentApt({ commit }, currentApt) {
			commit("CHANGE_CURRENT_APT", currentApt);
		},

		getInterestAreaInfo({ commit }, userInfo) {
			commit("INITIAL_SIDO_LIST");
			commit("INITIAL_GUGUN_LIST");
			commit("INITIAL_DONG_LIST");
			commit("INITIAL_APT_LIST");
			commit("OFF_CHECK_DISPLAY");
			http
				.get("/user/getArea", {
					params: {
						userId: userInfo.userId,
					},
				})
				.then((response) => {
					const [sidoName, gugunName, dongName] = response.data.split("_");
					// 시, 구, 동 밸류 업데이트
					http
						.get("/map/base", {
							params: {
								sidoName: sidoName,
								gugunName: gugunName,
								dongName: dongName,
							},
						})
						.then((res) => {
							let dongCode = res.data.dongCode;

							// 시도 코드 및 구군 코드 알았음
							let sidoCode = dongCode.substring(0, 2);
							let gugunCode = dongCode.substring(0, 5);

							commit("SET_SIDO_VALUE", { value: sidoCode, text: sidoName });
							commit("SET_GUGUN_VALUE", { value: gugunCode, text: gugunName });
							commit("SET_DONG_VALUE", { value: dongCode, text: dongName });

							http
								.get("/map/gugun", {
									params: {
										sido: sidoCode,
									},
								})
								.then((res) => {
									commit("SET_GUGUN_LIST", res.data);
								})
								.catch((err) => console.log(err));

							http
								.get("/map/dong", {
									params: {
										gugun: gugunCode,
									},
								})
								.then((res) => {
									commit("SET_DONG_LIST", res.data);
								});

							http
								.get("/map/apt", {
									params: {
										dong: dongCode,
									},
								})
								.then((res) => {
									commit("SET_APT_LIST", res.data);
									commit("ON_CHECK_DISPLAY");
								})
								.catch((err) => console.log(err));
						})
						.catch((err) => console.log(err));
				})
				.catch((error) => console.log(error));
		},

		clearAllStates({ commit }) {
			commit("INITIAL_GUGUN_LIST");
			commit("INITIAL_DONG_LIST");
			commit("INITIAL_APT_LIST");
			commit("INITIAL_SEARCH_WORD");
		},

		getOnlySido({ commit }) {
			http
				.get("/map/sido")
				.then((response) => {
					commit("SET_SIDO_LIST", response.data);
				})
				.catch((error) => {
					console.log(error);
				});
		},

		getCovidArea({ commit }) {
			http
				.get("/map/covid")
				.then((response) => {
					commit("INITIAL_COVID_LIST");
					console.log(response.data);
					commit("SET_COVID_LIST", response.data);
				})
				.catch((error) => console.log(error));
		},
	},
};

export default houseStore;
