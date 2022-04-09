<template>
  <b-container class="mt-5">
    <card>
      <!-- qna 내용 -->
      <b-table-simple hover responsive>
        <b-tr>
          <b-th> 글번호 </b-th>
          <b-td> {{ qna.qnaNo }}</b-td>
        </b-tr>
        <b-tr>
          <b-th> 작성자 </b-th>
          <b-td> {{ qna.userId }}</b-td>
        </b-tr>
        <b-tr>
          <b-th> 작성시간 </b-th>
          <b-td> {{ qna.regTime }}</b-td>
        </b-tr>
        <b-tr>
          <b-th> 제목 </b-th>
          <b-td> {{ qna.title }}</b-td>
        </b-tr>
        <b-tr>
          <b-th> 내용 </b-th>
          <b-td> {{ qna.content }}</b-td>
        </b-tr>
      </b-table-simple>
      <b-container v-if="qna.userId == userInfo.userId">
        <b-button variant="outline-danger" @click="deleteQna">삭제</b-button>
        <b-button v-if="!comment" variant="outline-info" @click="modifyQna"
          >수정</b-button
        >
      </b-container>
      <!-- 답변 -->
    </card>
    <card>
      <!-- <br /><br /> -->
      <comment-create />
      <br /><br />
    </card>
  </b-container>
</template>

<script>
import { Card } from "@/components/index";
import { mapActions, mapState } from "vuex";
import CommentCreate from "@/components/QnA/comment/CommentCreate";

const qnaStore = "qnaStore";
const userStroe = "userStore";

export default {
  name: "QnADetail",
  components: {
    CommentCreate,
    Card,
  },
  computed: {
    ...mapState(qnaStore, ["qna", "comment"]),
    ...mapState(userStroe, ["userInfo"]),
  },
  created() {
    this.getCommentInfo();
  },
  methods: {
    ...mapActions(qnaStore, ["getComment", "deleteQnA"]),
    // async deleteQna() {
    //   if (confirm("정말로 글을 삭제하시겠습니까?")) {
    //     await this.deleteQnA(this.qna.qnaNo);
    //     this.$router.push({ name: "QnAList" });
    //   }
    // },
    deleteQna() {
      if (confirm("글을 삭제하시겠습니까?")) {
        this.$router.push({
          name: "QnADelete",
          params: { no: this.qna.qnaNo },
        });
      }
    },
    modifyQna() {
      this.$router.push({ name: "QnAModify", params: { no: this.qna.qnaNo } });
    },
    getCommentInfo() {
      this.getComment(this.$route.params.no);
      // this.$router.push({ name: "QnADetail", params: { no: this.qna.qnaNo } });
    },
  },
};
</script>

<style></style>
