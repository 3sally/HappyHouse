<template>
  <card>
    <b-container class="mt-2">
      <h4>
        <mark>인기 공지사항</mark>
      </h4>
      <b-row>
        <b-col>
          <b-table
            hover
            :items="hotnotices"
            :fields="fields"
            per-page="5"
            thead-class="hidden_header"
            @row-clicked="showDetail"
          >
            <template #cell(subject)="data">
              {{ data.item.subject }}
              <b-badge variant="badge badge-danger">HOT</b-badge>
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

const noticeStore = "noticeStore";
const userStore = "userStore";

export default {
  name: "HotNotice",
  components: { Card },
  data() {
    return {
      fields: [
        { key: "articleNo", label: "글번호" },
        { key: "subject", label: "제목" },
        // { key: "views", label: "조회" },
      ],
    };
  },
  computed: {
    ...mapState(noticeStore, ["hotnotices"]),
    ...mapState(userStore, ["userInfo"]),
  },
  created() {
    this.hotNoticeList();
    // console.log("notices : ", this.notices);
  },
  methods: {
    ...mapActions(noticeStore, [
      "getHotNoticeList",
      "getNoticeDetail",
      "increaseViews",
    ]),
    hotNoticeList() {
      //   console.log("NoticeList.vue => noticeList()");
      this.getHotNoticeList();
    },
    showDetail(notice) {
      var no = notice.articleNo;
      this.increaseViews(no);
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
