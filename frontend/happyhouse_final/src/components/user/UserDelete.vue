<template>
  <b-container>
    <h2>회원 탈퇴 완료</h2>
    <b-button variant="outline-danger" @click="goHome">메인 페이지로</b-button>
  </b-container>
</template>

<script>
const userStore = "userStore";
import { mapActions, mapState, mapMutations } from "vuex";

export default {
  name: "UserDelete",
  computed: {
    ...mapState(userStore, ["userInfo"]),
  },
  created() {
    this.deleteMember();
  },
  methods: {
    ...mapMutations(userStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    ...mapActions(userStore, ["userDelete"]),
    deleteMember() {
      this.userDelete(this.userInfo.userId);
    },
    goHome() {
      this.SET_IS_LOGIN(false);
      this.SET_USER_INFO(null);
      sessionStorage.removeItem("access-token");
      if (this.$route.path != "/") this.$router.push({ name: "Dashboard" });
    },
  },
};
</script>

<style></style>
