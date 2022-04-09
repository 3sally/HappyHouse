<template>
  <b-container class="mt-2">
    <h4>공지사항 <b-badge variant="info">New</b-badge></h4>
    <b-row>
      <b-col>
        <b-table
          striped
          hover
          :items="notices"
          :fields="fields"
          per-page="3"
          thead-class="hidden_header"
          @row-clicked="showDetail"
        >
        </b-table>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapActions, mapState } from "vuex";

const noticeStore = "noticeStore";
const userStore = "userStore";

export default {
  name: "NoticeMiniList",
  components: {},
  data() {
    return {
      fields: [
        { key: "articleNo", label: "글번호" },
        { key: "subject", label: "제목" },
        // { key: "regTime", label: "작성일" },
      ],
    };
  },
  computed: {
    ...mapState(noticeStore, ["notices"]),
    ...mapState(userStore, ["userInfo"]),
  },
  created() {
    this.noticeList();
    console.log("notices : ", this.notices);
  },
  methods: {
    ...mapActions(noticeStore, ["getNoticeList", "getNoticeDetail"]),
    noticeList() {
      console.log("NoticeList.vue => noticeList()");
      this.getNoticeList();
    },
    showDetail(notice) {
      var no = notice.articleNo;
      this.getNoticeDetail(no);
      this.$router.push({ name: "NoticeDetail", params: { no: no } });
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
