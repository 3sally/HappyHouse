<template>
  <b-container class="mt-2">
    <b-button
      class="float-right"
      v-if="this.userInfo && this.userInfo.isAdmin"
      variant="success"
      @click="createNotice"
      >공지 작성하기</b-button
    >
    <br /><br />
    <vue-good-table
      theme="polar-bear"
      styleClass="vgt-table"
      :columns="columns"
      :rows="this.notices"
      @on-row-click="showDetail"
      :sort-options="{
        enabled: false,
      }"
      :pagination-options="{
        enabled: true,
        perPage: 10,
        perPageDropdownEnabled: false,
        prevLabel: '이전',
        nextLabel: '다음',
        mode: 'pages',
        pageLabel: '', // for 'pages' mode
      }"
      :search-options="{
        enabled: true,
      }"
    >
      <template slot="table-row" slot-scope="props">
        <span v-if="props.column.field == 'subject'"
          >{{ props.row.subject }} &nbsp;
          <span
            class="badge badge-success"
            v-if="formatDate(props.row.regTime) == date"
          >
            NEW</span
          >
          &nbsp;
          <span v-for="(hotnotice, index) in hotnotices" :key="index">
            <span
              class="badge badge-danger"
              v-if="props.row.articleNo == hotnotice.articleNo"
            >
              HOT</span
            >
          </span>
        </span>
      </template>
    </vue-good-table>
  </b-container>
</template>

<script>
import { mapActions, mapState } from "vuex";
import moment from "moment";

const noticeStore = "noticeStore";
const userStore = "userStore";

export default {
  name: "NoticeList",
  components: {},
  data() {
    return {
      columns: [
        { field: "articleNo", label: "글번호" },
        { field: "subject", label: "제목" },
        { field: "views", label: "조회수" },
      ],
      date: null,
    };
  },
  computed: {
    ...mapState(noticeStore, ["notices", "hotnotices"]),
    ...mapState(userStore, ["userInfo"]),
  },
  created() {
    this.noticeList();
    this.today();
  },
  methods: {
    ...mapActions(noticeStore, [
      "getNoticeList",
      "getNoticeDetail",
      "increaseViews",
      "getHotNoticeList",
    ]),
    noticeList() {
      // console.log("NoticeList.vue => noticeList()");
      this.getNoticeList();
      this.getHotNoticeList();
      // console.log(this.notices);
    },
    showDetail(notice) {
      console.log(notice);
      var no = notice.row.articleNo;
      this.increaseViews(no);
      this.getNoticeDetail(no);
      this.$router.push({ name: "NoticeDetail", params: { no: no } });
    },
    createNotice() {
      this.$router.push({ name: "NoticeCreate" });
    },
    formatDate(value) {
      const formattedDate = moment(value).format("YYYY-MM-DD");
      return formattedDate;
    },
    today() {
      var today = new Date();
      var year = today.getFullYear();
      var month = ("0" + (today.getMonth() + 1)).slice(-2);
      var day = ("0" + today.getDate()).slice(-2);
      var dateString = year + "-" + month + "-" + day;
      this.date = dateString;
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
</style>
