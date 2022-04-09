<template>
  <b-container class="bv-example-row mt-3">
    <notice-create-form type="modify" />
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
