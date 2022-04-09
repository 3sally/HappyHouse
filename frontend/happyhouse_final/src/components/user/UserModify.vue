<template>
  <card>
    <b-container class="bv-example-row mt-3">
      <b-row>
        <b-col>
          <b-alert variant="secondary" show><h3>내 정보 수정</h3></b-alert>
        </b-col>
        <div class="container">
          <!--  .prevent를 통해 새로고침을 막고 methods의 함수롤 호출 -->
          <form @submit.prevent="submitForm">
            <b-table-simple hover responsive>
              <b-tr>
                <b-td>
                  <label for="email">ID </label>
                </b-td>
                <b-td>
                  {{ user.userId }}
                </b-td>
              </b-tr>
              <b-tr>
                <b-td>
                  <label for="name">이름</label>
                </b-td>
                <b-td>
                  {{ user.userName }}
                </b-td>
              </b-tr>
              <b-tr>
                <b-td>
                  <label for="password">새 비밀번호</label>
                </b-td>
                <b-td>
                  <b-form-input
                    required
                    @keyup="passCheck"
                    @keydown="passConfirm"
                    type="password"
                  />
                  <br />
                  {{ this.passCheckMsg }}
                </b-td>
              </b-tr>
              <b-tr>
                <b-td>
                  <label for="passwordConfirm">새 비밀번호 확인</label>
                </b-td>
                <b-td>
                  <!-- <b-form-input v-model="user.userPassComfirm" required /> -->
                  <b-form-input
                    v-model="userPassConfirm"
                    required
                    type="password"
                    @keyup="passConfirm"
                  />
                  <br />
                  {{ this.passConfirmMsg }}
                </b-td>
              </b-tr>
              <b-tr>
                <b-td>
                  <label for="email">email </label>
                </b-td>
                <b-td>
                  <b-form-input v-model="user.userEmail" required />
                </b-td>
              </b-tr>
              <b-tr>
                <b-td>
                  <label for="email">phone </label>
                </b-td>
                <b-td>
                  <b-form-input v-model="user.userPhone" required />
                </b-td>
              </b-tr>

              <b-tr>
                <b-td>
                  <label for="interestArea">관심지역</label>
                </b-td>
                <b-td>
                  <div class="dropdown">
                    <div class="btn-group">
                      <b-dropdown class="select-list" :text="sidoValue.text">
                        <b-dropdown-item
                          v-for="(sido, index) in sidoList"
                          v-bind:key="index"
                          @click="setSidoValue(sido), getGuGun(sido)"
                          >{{ sido.text }}</b-dropdown-item
                        >
                      </b-dropdown>
                    </div>
                    <div class="btn-group">
                      <b-dropdown class="select-list" :text="gugunValue.text">
                        <b-dropdown-item
                          v-for="(gugun, index) in gugunList"
                          v-bind:key="index"
                          @click="setGuGunValue(gugun), getDong(gugun)"
                          >{{ gugun.text }}</b-dropdown-item
                        >
                      </b-dropdown>
                    </div>
                    <div class="btn-group">
                      <b-dropdown class="select-list" :text="dongValue.text">
                        <b-dropdown-item
                          v-for="(dong, index) in dongList"
                          v-bind:key="index"
                          @click="setDongValue(dong)"
                          >{{ dong.text }}</b-dropdown-item
                        >
                      </b-dropdown>
                    </div>
                  </div>
                </b-td>
              </b-tr>
            </b-table-simple>
            <b-button type="submit">정보 수정하기</b-button>
          </form>
        </div>
      </b-row>
    </b-container>
  </card>
</template>

<script>
import { mapActions, mapState, mapMutations } from "vuex";
import { Card } from "@/components/index";

const userStore = "userStore";
const houseStore = "houseStore";

export default {
  name: "UserJoin",
  data() {
    return {
      user: {
        userId: "",
        userName: "",
        userPass: "",
        // userPassConfirm: "",
        userEmail: "",
        userPhone: "",
        interestArea: "",
      },
      userPassConfirm: "",
      passCheckMsg: "",
      isPass: "",
      passConfirmMsg: "",
      isPassSame: "",
    };
  },
  components: {
    Card,
  },
  created() {
    console.log(this.userInfo);
    this.user = { ...this.userInfo };
    this.getSido();
  },
  computed: {
    ...mapState(userStore, ["userInfo"]),
    ...mapState(houseStore, [
      "sidoList",
      "sidoValue",
      "gugunList",
      "gugunValue",
      "dongList",
      "dongValue",
      "aptList",
    ]),
  },
  methods: {
    ...mapMutations(userStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    ...mapActions(userStore, ["updateUser", "modifyInterestArea"]),
    ...mapActions(houseStore, [
      "getSido",
      "setSidoValue",
      "getGuGun",
      "setGuGunValue",
      "getDong",
      "setDongValue",
      "getApt",
      "setSearchWord",
    ]),
    submitForm() {
      if (this.isPass && this.isPassSame) {
        this.interestArea();
        this.updateUser(this.user);
        alert("정보 수정이 완료되었습니다. 다시 로그인해주셔야합니다.");
        this.SET_IS_LOGIN(false);
        this.SET_USER_INFO(null);
        sessionStorage.removeItem("access-token");
        //정보 수정하면 다시 로그인으로 하게끔
        this.$router.push({ name: "UserLogin" });
      } else {
        if (!this.isPass) alert("비밀번호 길이를 확인해주세요(5-10자)");
        else if (!this.isPassSame) alert("비밀번호 확인을 다시 해주세요");
      }
    },
    async interestArea() {
      if (this.sidoValue && this.gugunValue && this.dongValue) {
        const userInterestArea =
          this.sidoValue.text +
          "_" +
          this.gugunValue.text +
          "_" +
          this.dongValue.text;
        console.log(userInterestArea);
        this.user.interestArea = userInterestArea;
        await this.modifyInterestArea({
          userId: this.userInfo.userId,
          interestArea: userInterestArea,
        });
      }
    },
    passCheck() {
      if (this.user.userPass.length < 5 || this.user.userPass.length > 10) {
        if (this.user.userId.length == 0) this.passCheckMsg = "";
        this.passCheckMsg = "비밀번호는 5자이상 10자이하입니다.";
        this.isPass = false;
      } else {
        this.passCheckMsg = "";
        this.isPass = true;
      }
    },
    passConfirm() {
      // console.log("userPass -> ", this.user.userPass);
      // console.log("userPassConfirm -> ", this.userPassConfirm);
      if (this.userPassConfirm == "") {
        this.passConfirmMsg = "";
        this.isPassSame = false;
      } else {
        if (this.user.userPass == this.userPassConfirm) {
          this.passConfirmMsg = "비밀번호가 같습니다^^";
          this.isPassSame = true;
        } else {
          this.passConfirmMsg = "비밀번호가 다릅니다!!!";
          this.isPassSame = false;
        }
      }
    },
  },
};
</script>

<style></style>
