<template>
  <card>
    <template slot="header">
      <h5 class="title">내 정보</h5>
    </template>
    <div class="row">
      <div class="col-md-4 pr-md-1 text-left">
        <base-input label="아이디" v-model="model.userId" disabled>
        </base-input>
      </div>
      <div class="col-md-8 pl-md-1 text-left">
        <base-input
          label="비밀번호"
          type="password"
          v-model="model.userPass"
          disabled
        >
        </base-input>
      </div>
    </div>

    <div class="row">
      <div class="col-md-4 pr-md-1 text-left">
        <base-input label="이름" v-model="model.userName" disabled>
        </base-input>
      </div>
      <div class="col-md-8 pl-md-1 text-left">
        <base-input
          label="Email address"
          v-model="model.userEmail"
          type="email"
          disabled
        >
        </base-input>
      </div>
    </div>

    <div class="row">
      <div class="col-md-12 text-left">
        <base-input label="번호" v-model="model.userPhone" disabled>
        </base-input>
      </div>
    </div>

    <div class="row">
      <div class="col-md-12 text-left">
        <base-input label="관심 지역" v-model="this.userInterestArea" disabled>
        </base-input>
      </div>
    </div>

    <template slot="footer">
      <base-button type="success" fill class="mr-1" @click="modifyUser"
        >정보수정</base-button
      >
      <base-button type="danger" @click="deleteUser">회원탈퇴</base-button>
    </template>
  </card>
</template>
<script>
import { mapState } from "vuex";
import { Card, BaseInput } from "@/components/index";

import BaseButton from "@/components/BaseButton";

const userStore = "userStore";

export default {
  components: {
    Card,
    BaseInput,
    BaseButton,
  },
  computed: {
    ...mapState(userStore, ["userInterestArea"]),
  },
  props: {
    model: {
      type: Object,
      default: () => {
        return {};
      },
    },
  },
  methods: {
    modifyUser() {
      this.$router.push({
        name: "UserModify",
        params: { no: this.model.userId },
      });
    },
    deleteUser() {
      if (confirm("정말 탈퇴하시겠습니까?")) {
        this.$router.push({
          name: "UserDelete",
          params: { no: this.userInfo.userId },
        });
      }
    },
  },
};
</script>
<style></style>
