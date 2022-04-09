<template>
  <b-container class="mt-5">
    <!-- <b-row>
      <b-col>
        <b-alert variant="secondary" show><h3>Login</h3></b-alert>
      </b-col>
    </b-row> -->
    <b-row>
      <b-col></b-col>
      <b-col cols="8">
        <b-card class="text-center mt-3" style="max-width: 40rem" align="left">
          <b-form class="text-left">
            <b-alert show variant="danger" v-if="isLoginError"
              >아이디 또는 비밀번호를 확인하세요.</b-alert
            >
            <b-form-group label="아이디:" label-for="userid">
              <b-form-input
                id="userid"
                v-model="user.userId"
                required
                placeholder="아이디 입력...."
                @keyup.enter="confirm"
              ></b-form-input>
            </b-form-group>
            <b-form-group label="비밀번호:" label-for="userpwd">
              <b-form-input
                type="password"
                id="userpwd"
                v-model="user.userPass"
                required
                placeholder="비밀번호 입력...."
                @keyup.enter="confirm"
              ></b-form-input>
            </b-form-group>
            <b-button
              type="button"
              variant="primary"
              class="m-1"
              @click="confirm"
              >로그인</b-button
            >
            <b-button
              type="button"
              variant="success"
              class="m-1"
              @click="movePage"
              >회원가입</b-button
            >
          </b-form>
        </b-card>
      </b-col>
      <b-col></b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapState, mapActions } from "vuex";

const userStore = "userStore";
const qnaStore = "qnaStore";

export default {
  name: "UserLogin",
  data() {
    return {
      user: {
        userId: null,
        userPass: null,
      },
    };
  },
  computed: {
    ...mapState(userStore, ["isLogin", "isLoginError"]),
  },
  methods: {
    ...mapActions(userStore, ["userConfirm", "getUserInfo"]),
    ...mapActions(qnaStore, ["getMyQnAList"]),
    async confirm() {
      await this.userConfirm(this.user);
      // console.log("user->", this.user);
      let token = sessionStorage.getItem("access-token");
      // console.log("token->", token);
      // console.log(this.isLogin);
      if (this.isLogin) {
        await this.getUserInfo(token);
        await this.getMyQnAList(this.user.userId);
        //임시로 dashboard로 가게 함
        this.$router.push({ name: "Dashboard" });
        // this.$router.go(this.$router.currentRoute);
      }
    },
    movePage() {
      this.$router.push({ name: "UserJoin" });
    },
  },
};
</script>

<style></style>
