<template>
  <b-container class="bv-example-row mt-3">
    <qn-a-create-form type="modify" />
  </b-container>
</template>

<script>
import QnACreateForm from "@/components/QnA/QnACreateForm";

export default {
  name: "QnAModify",
  components: {
    QnACreateForm,
  },
};
</script>

<style></style>
