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
            v-model="notice.userId"
            type="text"
            ref="userId"
            required
            placeholder="작성자 입력..."
          ></b-form-input>
        </b-form-group> -->

          <b-form-group id="title-group" label="제목:" label-for="title">
            <b-form-input
              id="title"
              v-model="notice.subject"
              type="text"
              ref="title"
              required
            ></b-form-input>
          </b-form-group>

          <b-form-group id="content-group" label="내용:" label-for="content">
            <b-form-textarea
              id="content"
              v-model="notice.content"
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
            @click="createArticle"
            >글등록</b-button
          >
          <b-button v-else variant="primary" class="m-1" @click="modifyArticle"
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
import { mapActions } from "vuex";
import { Card } from "@/components/index";

const noticeStore = "noticeStore";

export default {
  name: "NoticeCreateForm",
  data() {
    return {
      notice: {
        // userId: "",
        subject: "",
        content: "",
      },
      isUserId: false,
    };
  },
  components: { Card },

  props: {
    type: { type: String },
  },
  methods: {
    ...mapActions(noticeStore, ["createNotice", "modifyNotice"]),
    onReset(event) {
      event.preventDefault();
      if (confirm("작성한거 다 지우겠습니까?")) {
        // this.notice.userId = "";
        this.notice.subject = "";
        this.notice.content = "";
      }
    },
    async createArticle() {
      await this.createNotice(this.notice);
      alert("공지가 등록되었습니다");
      this.moveList();
    },
    async modifyArticle() {
      await this.modifyNotice({
        no: this.$route.params.no,
        notice: this.notice,
      });
      alert("작성하신 공지가 수정되었습니다");
      this.moveList();
    },
    moveList() {
      this.$router.push({ name: "NoticeList" });
    },
  },
};
</script>

<style></style>
