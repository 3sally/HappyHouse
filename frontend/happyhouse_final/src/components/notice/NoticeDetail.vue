<template>
  <card>
    <b-container>
      <!-- qna 내용 -->
      <b-table-simple hover responsive>
        <b-tr>
          <b-th> 글번호 </b-th>
          <b-td> {{ notice.articleNo }}</b-td>
        </b-tr>
        <b-tr>
          <b-th> 작성시간 </b-th>
          <b-td> {{ notice.regTime }}</b-td>
        </b-tr>
        <b-tr>
          <b-th> 조회수 </b-th>
          <b-td> {{ notice.views }}</b-td>
        </b-tr>
        <b-tr>
          <b-th> 제목 </b-th>
          <b-td> {{ notice.subject }}</b-td>
        </b-tr>
        <b-tr>
          <b-th> 내용 </b-th>
          <b-td> {{ notice.content }}</b-td>
        </b-tr>
      </b-table-simple>
      <b-button
        v-if="this.userInfo.isAdmin"
        variant="outline-danger"
        @click="deleteNotice"
        >삭제</b-button
      >
      <b-button
        v-if="this.userInfo.isAdmin"
        variant="outline-info"
        @click="modifyNotice"
        >수정</b-button
      >
    </b-container>
  </card>
</template>

<script>
import { Card } from "@/components/index";
import { mapState } from "vuex";

const noticeStore = "noticeStore";
const userStore = "userStore";

export default {
  name: "NoticeDetail",
  components: { Card },

  computed: {
    ...mapState(noticeStore, ["notice"]),
    ...mapState(userStore, ["userInfo"]),
  },
  methods: {
    // ...mapActions(noticeStore, ["deleteNotice"]),
    deleteNotice() {
      if (confirm("글을 삭제하시겠습니까?")) {
        this.$router.push({
          name: "NoticeDelete",
          params: { no: this.notice.articleNo },
        });
      }
    },
    // deleteArticle() {
    //   if (confirm("글을 삭제하시겠습니까?")) {
    //     this.deleteNotice(this.notice.articleNo);
    //     this.$router.push({ name: "NoticeList" });
    //   }
    // },
    modifyNotice() {
      this.$router.push({
        name: "NoticeModify",
        params: { no: this.notice.articleNo },
      });
    },
  },
};
</script>

<style></style>
