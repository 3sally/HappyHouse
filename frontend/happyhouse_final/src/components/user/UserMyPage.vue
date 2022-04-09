<template>
  <b-container class="mt-4" v-if="userInfo">
    <b-row>
      <b-col>
        <b-alert variant="secondary" show><h3>My Page</h3></b-alert>
      </b-col>
    </b-row>
    <b-row>
      <b-col></b-col>
      <b-col cols="8">
        <b-jumbotron>
          <hr class="my-4" />

          <b-container class="mt-4">
            <b-row>
              <b-col cols="2"></b-col>
              <b-col cols="2" align-self="end">아이디</b-col
              ><b-col cols="4" align-self="start">{{ userInfo.userId }}</b-col>
              <b-col cols="2"></b-col>
            </b-row>
            <b-row>
              <b-col cols="2"></b-col>
              <b-col cols="2" align-self="end">이름</b-col
              ><b-col cols="4" align-self="start">{{
                userInfo.userName
              }}</b-col>
              <b-col cols="2"></b-col>
            </b-row>
            <b-row>
              <b-col cols="2"></b-col>
              <b-col cols="2" align-self="end">이메일</b-col
              ><b-col cols="4" align-self="start">{{
                userInfo.userEmail
              }}</b-col>
              <b-col cols="2"></b-col>
            </b-row>
            <b-row>
              <b-col cols="2"></b-col>
              <b-col cols="2" align-self="end">번호</b-col
              ><b-col cols="4" align-self="start">{{
                userInfo.userPhone
              }}</b-col>
              <b-col cols="2"></b-col>
            </b-row>
            <b-row>
              <b-col cols="1"></b-col>
              <b-col cols="3" align-self="end">관심 지역</b-col
              ><b-col cols="6" align-self="start">{{ userInterestArea }}</b-col>
            </b-row>
          </b-container>
          <hr class="my-4" />

          <b-button variant="primary" class="mr-1" @click="modifyUser"
            >정보수정</b-button
          >
          <b-button variant="danger" @click="deleteUser">회원탈퇴</b-button>
        </b-jumbotron>
      </b-col>
      <b-col></b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapActions, mapState } from "vuex";

const userStore = "userStore";

export default {
  name: "UserMyPage",
  created() {
    // console.log(this.userInfo);
    this.getUserInterestArea({ userId: this.userInfo.userId });
    // console.log("this.userInterestArea -> ", this.userInterestArea);
  },
  computed: {
    ...mapState(userStore, ["userInfo", "userInterestArea"]),
  },
  methods: {
    ...mapActions(userStore, ["getUserInterestArea"]),
    deleteUser() {
      if (confirm("정말 탈퇴하시겠습니까?")) {
        this.$router.push({
          name: "UserDelete",
          params: { no: this.userInfo.userId },
        });
      }
    },
    modifyUser() {
      this.$router.push({
        name: "UserModify",
        params: { no: this.userInfo.userId },
      });
    },
  },
};
</script>

<style></style>
