<template>
  <b-container class="bv-example-row mt-3">
    <h2>Q&A</h2>
    <qn-a-create-form type="register" />
  </b-container>
</template>

<script>
import QnACreateForm from "@/components/QnA/QnACreateForm";

export default {
  name: "QnACreate",
  components: {
    QnACreateForm,
  },
};
</script>

<style></style>
