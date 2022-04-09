<template>
  <b-container class="mt-5">
    <b-table-simple hover responsive>
      <b-tr>
        <b-th> 답변 </b-th>
      </b-tr>
      <b-tr v-if="comment">
        <b-container v-if="!userInfo.isAdmin">
          {{ comment.content }}
        </b-container>
        <b-container v-if="this.userInfo.isAdmin">
          <base-input v-model="comment.content"> </base-input>
          <b-button @click="modifyComment">답변 수정</b-button>
          <b-button @click="deleteComment">답변 삭제</b-button>
        </b-container>
      </b-tr>
      <b-tr v-else>
        <b-container v-if="this.userInfo.isAdmin">
          <b-form-input v-model="answer" placeholder="..."></b-form-input>
          <b-button @click="createComment">답변 등록</b-button>
        </b-container>
        <b-container v-else>
          ...
        </b-container>
      </b-tr>
    </b-table-simple>
  </b-container>
</template>

<script>
import { BaseInput } from "@/components/index";
import { mapActions, mapState } from "vuex";
const qnaStore = "qnaStore";
const userStore = "userStore";

export default {
  name: "CommentCreate",
  data() {
    return {
      answer: null,
    };
  },
  components: {
    BaseInput,
  },
  computed: {
    ...mapState(qnaStore, ["qna", "comment"]),
    ...mapState(userStore, ["userInfo"]),
  },
  methods: {
    ...mapActions(qnaStore, ["setComment", "changeComment", "delComment"]),
    setAnswer() {
      this.answer = comment.content;
      console.log("gege", comment.content);
    },
    async createComment() {
      await this.setComment({
        qnaNo: this.qna.qnaNo,
        userId: this.qna.userId,
        content: this.answer,
      });
      this.$router.push({ name: "QnAList" });
    },
    async modifyComment() {
      if (!this.comment.content) {
        alert("답변을 작성해주세요");
      } else {
        await this.changeComment({
          qnaNo: this.qna.qnaNo,
          userId: this.qna.userId,
          content: this.comment.content,
        });
        this.$router.push({ name: "QnAList" });
      }
    },
    async deleteComment() {
      await this.delComment(this.qna.qnaNo);
      this.$router.push({ name: "QnAList" });
    },
  },
};
</script>

<style></style>
