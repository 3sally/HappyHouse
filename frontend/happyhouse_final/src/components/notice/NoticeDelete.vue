<template>
  <card>
    <b-container>
      <h2>삭제 완료</h2>
      <b-button variant="outline-danger" @click="goList">목록가기</b-button>
    </b-container>
  </card>
</template>

<script>
const noticeStore = "noticeStore";
import { Card } from "@/components/index";
import { mapActions, mapState } from "vuex";

export default {
  name: "NoticeDelete",
  computed: {
    ...mapState(noticeStore, ["notice"]),
  },
  components: { Card },

  created() {
    this.deleteArticle();
  },
  methods: {
    ...mapActions(noticeStore, ["deleteNotice"]),
    deleteArticle() {
      this.deleteNotice(this.notice.articleNo);
    },
    goList() {
      this.$router.push({ name: "NoticeList" });
    },
  },
};
</script>

<style></style>
