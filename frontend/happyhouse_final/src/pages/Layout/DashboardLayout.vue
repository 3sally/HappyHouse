<template>
  <div class="wrapper">
    <side-bar :background-color="backgroundColor">
      <sidebar-link to="/dashboard">
        <i class="tim-icons icon-chart-pie-36"></i>
        <p>Dashboard</p>
      </sidebar-link>
      <sidebar-link to="/maps">
        <i class="tim-icons icon-pin"></i>
        <p>Maps</p>
      </sidebar-link>
      <sidebar-link to="/notice">
        <i class="tim-icons icon-volume-98"></i>
        <p>NOTICE</p>
      </sidebar-link>
      <sidebar-link to="/qna">
        <i class="tim-icons icon-chat-33"></i>
        <p>QNA</p>
      </sidebar-link>
      <sidebar-link v-if="userInfo" to="/user">
        <i class="tim-icons icon-single-02"></i>
        <p>User Profile</p>
      </sidebar-link>
      <sidebar-link v-if="userInfo && userInfo.isAdmin" to="/user/list">
        <i class="tim-icons icon-planet"></i>
        <p>Member Management</p>
      </sidebar-link>
    </side-bar>

    <div class="main-panel" :data="backgroundColor">
      <top-navbar></top-navbar>
      <dashboard-content @click.native="toggleSidebar"></dashboard-content>
      <content-footer></content-footer>
    </div>
  </div>
</template>
<style lang="scss"></style>
<script>
import TopNavbar from "./TopNavbar.vue";
import ContentFooter from "./ContentFooter.vue";
import DashboardContent from "./DashboardContent.vue";
import SideBar from "@/components/SidebarPlugin/SideBar.vue";
import SidebarLink from "@/components/SidebarPlugin/SidebarLink.vue";

import { mapState } from "vuex";

const userStore = "userStore";

export default {
  components: {
    TopNavbar,
    DashboardContent,
    ContentFooter,
    SideBar,
    SidebarLink,
  },
  data() {
    return {
      backgroundColor: "green",
    };
  },
  computed: {
    ...mapState(userStore, ["userInfo"]),
  },
  methods: {
    toggleSidebar() {
      if (this.$sidebar.showSidebar) {
        this.$sidebar.displaySidebar(false);
      }
    },
  },
};
</script>
