<template>
  <card>
    <b-container class="mt-2">
      <h4>문의하러 가기</h4>
      <div class="embed-responsive embed-responsive-4by3">
        <img
          src="@/assets/img/qna.jpeg"
          class="card-img-top embed-responsive-item"
          alt="tree"
          @click="goQnA"
        />
      </div>
    </b-container>
  </card>
</template>

<script>
import { Card } from "@/components/index";

export default {
  name: "GoQnA",
  components: { Card },
  data() {
    return {};
  },
  methods: {
    goQnA() {
      //여기 누르면 qnalist로 갈지 qnacreate로 갈지 못 정하겠다!!
      //   this.$router.push({ name: "QnA" });
      this.$router.push({ name: "QnACreate" });
    },
  },
};
</script>
