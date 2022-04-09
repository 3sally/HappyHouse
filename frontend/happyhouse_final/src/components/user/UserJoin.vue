<template>
  <b-container class="bv-example-row mt-3">
    <b-row>
      <b-col>
        <b-alert variant="secondary" show><h3>회원가입</h3></b-alert>
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
                <b-form-input v-model="user.userId" required @keyup="idCheck" />
                <br />
                <span class="badge badge-warning float-left">{{
                  this.idCheckMsg
                }}</span>
              </b-td>
            </b-tr>
            <b-tr>
              <b-td>
                <label for="name">성함</label>
              </b-td>
              <b-td>
                <b-form-input v-model="user.userName" required />
              </b-td>
            </b-tr>
            <b-tr>
              <b-td>
                <label for="password">비밀번호</label>
              </b-td>
              <b-td>
                <b-form-input
                  v-model="user.userPass"
                  @keyup="passCheck"
                  @keydown="passConfirm"
                  type="password"
                  required
                />
                <br />
                <span class="badge badge-warning mt-1 float-left">{{
                  this.passCheckMsg
                }}</span>
              </b-td>
            </b-tr>
            <b-tr>
              <b-td>
                <label for="passwordConfirm">비밀번호 확인</label>
              </b-td>
              <b-td>
                <b-form-input
                  v-model="userPassConfirm"
                  required
                  @keyup="passConfirm"
                  type="password"
                />
                <br />
                <span class="badge badge-warning mt-1 float-left">{{
                  this.passConfirmMsg
                }}</span>
              </b-td>
            </b-tr>
            <b-tr>
              <b-td>
                <label for="email">email </label>
              </b-td>
              <b-td>
                <b-form-input v-model="user.userEmail" required />
                <!-- <span
                  class="badge badge-danger mt-1"
                  v-if="!checkEmail(user.userEmail)"
                  >이메일 형식이 다릅니다.</span
                > -->
              </b-td>
            </b-tr>
            <b-tr>
              <b-td>
                <label for="email">phone </label>
              </b-td>
              <b-td>
                <b-form-input v-model="user.userPhone" type="text" required />
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

          <b-button type="submit">회원가입</b-button>
        </form>
      </div>
    </b-row>
  </b-container>
</template>

<script>
import { mapState, mapActions, mapMutations } from "vuex";

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
        userAddr: "",
        interestArea: "",
      },
      idCheckMsg: "",
      isId: "",
      userPassConfirm: "",
      passCheckMsg: "",
      isPass: "",
      passConfirmMsg: "",
      isPassSame: "",
    };
  },
  created() {
    this.getSido();
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
    ...mapState(userStore, ["idcount"]),
  },
  watch: {
    idcount: function(data) {
      // console.log(data);
      // console.log("idcount!! -> ", data);
      if (data == 0) {
        this.idCheckMsg = "사용 가능한 아이디입니다.";
        this.isId = true;
      } else if (data == 1) {
        this.idCheckMsg = "이미 사용중인 아이디입니다ㅜㅜ";
        this.isId = false;
      }
      console.log("idCheckMsg!! -> ", this.idCheckMsg);
    },
  },
  methods: {
    ...mapMutations(userStore, ["INITIAL_IDCOUNT"]),
    ...mapActions(userStore, ["userJoin", "IdCheck"]),
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
      if (this.isId && this.isPass && this.isPassSame) {
        this.interestArea();
        this.userJoin(this.user);
        alert("회원가입이 완료되었습니다.");
        //임시로 dashboard로 가게 함
        this.$router.push({ name: "Dashboard" });
      } else {
        if (!this.isPass) alert("비밀번호 길이를 확인해주세요(5-10자)");
        else if (!this.isPassSame) alert("비밀번호 확인을 다시 해주세요");
        else if (!this.isId) alert("아이디 확인해주세요");
      }
    },
    interestArea() {
      const userInterestArea =
        this.sidoValue.text +
        "_" +
        this.gugunValue.text +
        "_" +
        this.dongValue.text;
      this.user.interestArea = userInterestArea;
      console.log("userInterestArea ->", userInterestArea);
    },
    idCheck() {
      console.log("idCheck!! -> ", this.user.userId);
      if (this.user.userId.length < 6 || this.user.userId.length > 16) {
        this.idCheckMsg = "아이디는 6자이상 16자이하입니다.";
        this.isId = false;
        this.INITIAL_IDCOUNT(-1);
        console.log(this.idcount);
      } else {
        this.IdCheck({ ckid: this.user.userId });
        // console.log("idcount!! -> ", this.idcount);
        // if (this.idcount == 0) {
        //   this.idCheckMsg = "사용 가능한 아이디입니다.";
        //   this.isId = true;
        // } else if (this.idcount == 1) {
        //   this.idCheckMsg = "이미 사용중인 아이디입니다ㅜㅜ";
        //   this.isId = false;
        // }
        // console.log("idCheckMsg!! -> ", this.idCheckMsg);
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
    // 이메일 정규표현식 체크
    // checkEmail(myValue) {
    //   var email = myValue;
    //   var exptext = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일 정규식
    //   if (exptext.test(email) == false) {
    //     //이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
    //     //alert("이메일형식이 올바르지 않습니다.");
    //     console.log("email false");
    //     return false;
    //   }
    //   console.log("email true");
    //   return true;
    // },
  },
};
</script>

<style></style>
