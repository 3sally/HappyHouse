<template>
  <b-container class="mt-2">
    <vue-good-table
      theme="polar-bear"
      styleClass="vgt-table"
      :columns="columns"
      :rows="this.users"
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
    </vue-good-table>
  </b-container>
</template>

<script>
import { mapActions, mapState } from "vuex";

const userStore = "userStore";

export default {
  name: "UserList",
  components: {},
  data() {
    return {
      columns: [
        { field: "userId", label: "아이디" },
        // { field: "userPass", label: "비밀번호" },
        { field: "userName", label: "이름" },
        { field: "userPhone", label: "핸드폰" },
        { field: "userEmail", label: "이메일" },
        { field: "interestArea", label: "관심지역" },
      ],
    };
  },
  computed: {
    ...mapState(userStore, ["users"]),
  },
  created() {
    this.userList();
  },
  methods: {
    ...mapActions(userStore, ["getUserList"]),
    userList() {
      this.getUserList();
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
