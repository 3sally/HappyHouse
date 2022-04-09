<template>
  <card>
    <b-container class="mt-2">
      <h4><mark> 최근 공지사항</mark></h4>
      <b-row>
        <b-col>
          <b-table
            hover
            :items="notices"
            :fields="fields"
            per-page="5"
            thead-class="hidden_header"
            @row-clicked="showDetail"
          >
            <template #cell(subject)="data">
              {{ data.item.subject }}
              <span
                class="badge badge-success"
                v-if="formatDate(data.item.regTime) == date"
              >
                NEW</span
              >
            </template>
          </b-table>
        </b-col>
      </b-row>
    </b-container>
  </card>
</template>

<script>
import { Card } from "@/components/index";
import { mapActions, mapState } from "vuex";
import moment from "moment";

const noticeStore = "noticeStore";
const userStore = "userStore";

export default {
  name: "NewNotice",
  components: { Card },
  data() {
    return {
      fields: [
        { key: "articleNo", label: "글번호" },
        { key: "subject", label: "제목" },
        // { key: "regTime", label: "작성일" },
      ],
      date: null,
    };
  },
  computed: {
    ...mapState(noticeStore, ["notices"]),
    ...mapState(userStore, ["userInfo"]),
  },
  created() {
    this.noticeList();
    this.today();
    // console.log("notices : ", this.notices);
  },
  methods: {
    ...mapActions(noticeStore, [
      "getNoticeList",
      "getNoticeDetail",
      "increaseViews",
    ]),
    noticeList() {
      // console.log("NoticeList.vue => noticeList()");
      this.getNoticeList();
    },
    showDetail(notice) {
      var no = notice.articleNo;
      this.increaseViews(no);
      this.getNoticeDetail(no);
      this.$router.push({ name: "NoticeDetail", params: { no: no } });
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
.hidden_header {
  display: none;
}
</style>
