<template>
  <b-container class="bv-example-row mt-3">
    <h2>공지사항</h2>
    <notice-create-form type="register" />
  </b-container>
</template>

<script>
import NoticeCreateForm from "@/components/notice/NoticeCreateForm";

export default {
  name: "NoticeCreate",
  components: {
    NoticeCreateForm,
  },
};
</script>

<style></style>
