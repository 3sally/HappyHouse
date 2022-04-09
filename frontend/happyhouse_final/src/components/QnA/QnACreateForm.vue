<template>
  <card>
    <b-row class="mb-1">
      <b-col style="text-align: left">
        <b-form>
          <!-- <b-form-group
          id="userId-group"
          label="작성자:"
          label-for="userId"
          description="작성자를 입력하세요."
        >
          <b-form-input
            id="userId"
            :disabled="isUserId"
            v-model="qna.userId"
            type="text"
            ref="userId"
            required
            placeholder="작성자 입력..."
          ></b-form-input>
        </b-form-group> -->

          <b-form-group
            id="title-group"
            label="제목:"
            label-for="title"
            description="제목을 입력하세요."
          >
            <b-form-input
              id="title"
              v-model="qna.title"
              type="text"
              ref="title"
              required
              placeholder="제목 입력..."
            ></b-form-input>
          </b-form-group>

          <b-form-group id="content-group" label="내용:" label-for="content">
            <b-form-textarea
              id="content"
              v-model="qna.content"
              ref="content"
              placeholder="내용 입력..."
              rows="10"
              max-rows="15"
              required
            ></b-form-textarea>
          </b-form-group>

          <b-button
            v-if="this.type === 'register'"
            variant="primary"
            class="m-1"
            @click="createQna"
            >글작성</b-button
          >
          <b-button v-else variant="primary" class="m-1" @click="modifyQna"
            >글수정</b-button
          >
          <b-button variant="danger" class="m-1" @click="onReset"
            >초기화</b-button
          >
        </b-form>
      </b-col>
    </b-row>
  </card>
</template>

<script>
import { mapActions, mapState } from "vuex";
import { Card } from "@/components/index";

const qnaStore = "qnaStore";
const userStore = "userStore";

export default {
  name: "QnACreateForm",
  data() {
    return {
      qna: {
        userId: "",
        title: "",
        content: "",
      },
      isUserId: false,
    };
  },
  components: { Card },
  props: {
    type: { type: String },
  },
  computed: {
    ...mapState(userStore, ["userInfo"]),
  },
  methods: {
    ...mapActions(qnaStore, ["createQnA", "modifyQnA"]),
    onReset(event) {
      event.preventDefault();
      if (confirm("작성한거 다 지우겠습니까?")) {
        // this.qna.userId = "";
        this.qna.title = "";
        this.qna.content = "";
      }
    },
    async createQna() {
      this.qna.userId = this.userInfo.userId;
      await this.createQnA(this.qna);
      alert("문의가 등록되었습니다");
      this.moveList();
    },
    async modifyQna() {
      this.qna.userId = this.userInfo.userId;
      await this.modifyQnA({ no: this.$route.params.no, qna: this.qna });
      alert("작성하신 문의가 수정되었습니다");
      this.moveList();
    },
    moveList() {
      this.$router.push({ name: "QnAList" });
    },
  },
};
</script>

<style></style>
