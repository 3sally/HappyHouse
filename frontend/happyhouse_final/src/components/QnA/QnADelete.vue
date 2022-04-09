<template>
  <card>
    <b-container>
      <h2>삭제 완료</h2>
      <b-button variant="outline-danger" @click="goList">목록가기</b-button>
    </b-container>
  </card>
</template>

<script>
const qnaStore = "qnaStore";
import { mapActions, mapState } from "vuex";
import { Card } from "@/components/index";
export default {
  name: "QnADelete",
  computed: {
    ...mapState(qnaStore, ["qna"]),
  },
  components: { Card },

  created() {
    this.deleteQna();
  },
  methods: {
    ...mapActions(qnaStore, ["deleteQnA"]),
    deleteQna() {
      this.deleteQnA(this.qna.qnaNo);
    },
    goList() {
      this.$router.push({ name: "QnAList" });
    },
  },
};
</script>

<style></style>
