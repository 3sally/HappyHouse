<template>
  <div class="content">
    <div class="row">
      <div class="col-md-12">
        <edit-profile-form :model="model"> </edit-profile-form>
      </div>
    </div>
  </div>
</template>
<script>
import { mapState, mapActions } from "vuex";
import UserMyPage from "../components/user/UserMyPage.vue";
import EditProfileForm from "./Profile/EditProfileForm.vue";

const userStore = "userStore";

export default {
  components: {
    EditProfileForm,
    UserMyPage,
  },
  data() {
    return {
      model: {},
    };
  },
  created() {
    this.setMyPage();
    this.getUserInterestArea({ userId: this.userInfo.userId });
  },
  computed: {
    ...mapState(userStore, ["userInfo"]),
  },
  methods: {
    ...mapActions(userStore, ["getUserInterestArea"]),
    setMyPage() {
      this.model = this.userInfo;
    },
  },
};
</script>
<style></style>
