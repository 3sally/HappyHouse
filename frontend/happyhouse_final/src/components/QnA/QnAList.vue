<template>
  <b-container class="mt-2">
    <b-button
      class="float-right"
      v-if="this.userInfo && !this.userInfo.isAdmin"
      pill
      variant="success"
      @click="createQnA"
      >문의하기</b-button
    >
    <br /><br />
    <vue-good-table
      theme="polar-bear"
      styleClass="vgt-table"
      :columns="columns"
      :rows="this.qnas"
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
        <span v-if="props.column.field == 'title'"
          >{{ props.row.title }} &nbsp;
          <span class="badge badge-warning" v-if="!props.row.comment">
            답변 대기</span
          >
          <span class="badge badge-info" v-else-if="props.row.comment">
            답변 완료</span
          >
        </span>
      </template>
    </vue-good-table>
  </b-container>
</template>

<script>
import { mapActions, mapState } from "vuex";
import moment from "moment";

const qnaStore = "qnaStore";
const userStore = "userStore";

export default {
  name: "QnAList",
  components: {},
  data() {
    return {
      columns: [
        { field: "qnaNo", label: "글번호" },
        { field: "title", label: "제목" },
        { field: "userId", label: "작성자" },
      ],
    };
  },
  computed: {
    ...mapState(qnaStore, ["qnas"]),
    ...mapState(userStore, ["userInfo"]),
  },
  created() {
    this.qnaList();
  },
  methods: {
    ...mapActions(qnaStore, ["getQnAList", "getQnADetail", "getComment"]),
    qnaList() {
      this.getQnAList();
      console.log(this.qnas);
    },
    showDetail(qna) {
      var no = qna.row.qnaNo;
      this.getQnADetail(no);
      // console.log("qna => ", qna);
      // this.getComment(no);
      this.$router.push({ name: "QnADetail", params: { no: no } });
    },
    createQnA() {
      this.$router.push({ name: "QnACreate" });
    },
    formatDate(value) {
      const formattedDate = moment(value).format("YYYY-MM-DD");
      return formattedDate;
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
