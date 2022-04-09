<template>
  <card>
    <b-container v-if="userInfo && !userInfo.isAdmin" class="mt-2">
      <h4>
        <mark>{{ this.userInfo.userId }}님이 작성한 문의사항</mark>
      </h4>
      <b-row>
        <b-col>
          <b-table
            hover
            id="myqna"
            :items="myqnas"
            :fields="fields"
            :per-page="perPage"
            :current-page="currentPage"
            thead-class="hidden_header"
            @row-clicked="showDetail"
          >
            <template #cell(title)="data">
              {{ data.item.title }}
              <span class="badge badge-warning" v-if="!data.item.comment">
                답변 대기</span
              >
              <span class="badge badge-info" v-else-if="data.item.comment">
                답변 완료</span
              >
            </template>
          </b-table>
          <div v-if="rows != 0">
            <b-pagination
              align="center"
              v-model="currentPage"
              :total-rows="rows"
              :per-page="perPage"
              aria-controls="myqna"
            ></b-pagination>
          </div>
          <div v-else>
            <h5><mark>작성하신 문의글이 없습니다</mark></h5>
          </div>
        </b-col>
      </b-row>
    </b-container>
    <b-container v-else-if="userInfo && userInfo.isAdmin">
      <h5><mark>관리자 권한으로 접속하였습니다</mark></h5>
      <br />
      <b-button type="button" variant="primary" class="m-1" @click="goUsers"
        >회원관리</b-button
      >
      <br />
      <b-button
        type="button"
        variant="primary"
        class="m-1"
        @click="goWriteNotice"
        >공지사항 작성하기</b-button
      >
    </b-container>
    <b-container v-else>
      <h5><mark>※회원에게만 보여지는 공간입니다※</mark></h5>
      <br />
      <b-button type="button" variant="primary" class="m-1" @click="goLogin"
        >로그인</b-button
      >
    </b-container>
  </card>
</template>

<script>
import { Card } from "@/components/index";
import { mapActions, mapState } from "vuex";

const qnaStore = "qnaStore";
const userStore = "userStore";

export default {
  name: "MyQnA",
  components: { Card },
  data() {
    return {
      perPage: 5,
      currentPage: 1,
      fields: [
        { key: "qnaNo", label: "글번호" },
        { key: "title", label: "제목" },
      ],
    };
  },
  computed: {
    ...mapState(qnaStore, ["myqnas"]),
    ...mapState(userStore, ["userInfo"]),
    rows() {
      return this.myqnas.length;
    },
  },
  created() {
    this.qnaList();
  },
  methods: {
    ...mapActions(qnaStore, ["getMyQnAList", "getQnADetail", "getComment"]),
    qnaList() {
      this.getMyQnAList(this.userInfo.userId);
    },
    showDetail(qna) {
      // console.log(qna);
      var no = qna.qnaNo;
      this.getQnADetail(no);
      this.$router.push({ name: "QnADetail", params: { no: no } });
    },
    goLogin() {
      this.$router.push({ name: "UserLogin" });
    },
    goWriteNotice() {
      this.$router.push({ name: "NoticeCreate" });
    },
    goUsers() {
      this.$router.push({ name: "UserList" });
    },
  },
};
</script>

<style scope>
.tdClass {
  width: 50px;
  text-align: center;
}
.tdSubject {
  width: 300px;
  text-align: left;
}
.hidden_header {
  display: none;
}
</style>
