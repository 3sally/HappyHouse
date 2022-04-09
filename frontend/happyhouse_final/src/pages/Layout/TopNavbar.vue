<template>
  <nav
    class="navbar navbar-expand-lg navbar-absolute"
    :class="{ 'bg-white': showMenu, 'navbar-transparent': !showMenu }"
  >
    <div class="container-fluid">
      <div class="navbar-wrapper">
        <div
          class="navbar-toggle d-inline"
          :class="{ toggled: $sidebar.showSidebar }"
        >
          <button type="button" class="navbar-toggler" @click="toggleSidebar">
            <span class="navbar-toggler-bar bar1"></span>
            <span class="navbar-toggler-bar bar2"></span>
            <span class="navbar-toggler-bar bar3"></span>
          </button>
        </div>
        <a class="navbar-brand" @click="goHome"> HAPPY HOUSE</a>
      </div>
      <button
        class="navbar-toggler"
        type="button"
        @click="toggleMenu"
        data-toggle="collapse"
        data-target="#navigation"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-bar navbar-kebab"></span>
        <span class="navbar-toggler-bar navbar-kebab"></span>
        <span class="navbar-toggler-bar navbar-kebab"></span>
      </button>
      <div class="collapse navbar-collapse show text-left" v-show="showMenu">
        <ul class="navbar-nav" :class="$rtl.isRTL ? 'mr-auto' : 'ml-auto'">
          <drop-down>
            <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
              <div class="photo">
                <i v-if="userInfo" class="tim-icons icon-satisfied"></i>
                <i v-else class="tim-icons icon-single-02"></i>
                <!-- <img src="@/assets/img/anime3.png" alt="Profile Photo" /> -->
              </div>
            </a>
            <ul class="dropdown-menu dropdown-navbar">
              <li v-if="userInfo" class="nav-link">
                <button class="nav-item dropdown-item">
                  {{ userInfo.userName }}({{ userInfo.userId }})님
                </button>
              </li>
              <li v-if="userInfo" class="nav-link">
                <button class="nav-item dropdown-item" @click="profile">
                  Profile
                </button>
              </li>
              <!-- <li class="nav-link">
                <a href="javascript:void(0)" class="nav-item dropdown-item"
                  >Settings</a
                >
              </li> -->
              <li class="dropdown-divider"></li>
              <li v-if="!userInfo" class="nav-link">
                <button class="nav-item dropdown-item" @click="login">
                  로그인
                </button>
              </li>
              <li v-if="!userInfo" class="nav-link">
                <button class="nav-item dropdown-item" @click="join">
                  회원가입
                </button>
              </li>
              <li v-if="userInfo" class="nav-link">
                <button class="nav-item dropdown-item" @click="logout">
                  로그아웃
                </button>
              </li>
            </ul>
          </drop-down>
        </ul>
      </div>
    </div>
  </nav>
</template>
<script>
import DropDown from "@/components/Dropdown.vue";
import Modal from "@/components/Modal.vue";
import { SidebarPlugin } from "@/components/index";
import { mapMutations, mapState } from "vuex";

const userStore = "userStore";
const qnaStore = "qnaStore";

export default {
  components: {
    DropDown,
    Modal,
    SidebarPlugin,
  },
  data() {
    return {
      searchModalVisible: false,
      searchQuery: "",
      showMenu: false,
    };
  },
  computed: {
    ...mapState(userStore, ["userInfo"]),
    isRTL() {
      return this.$rtl.isRTL;
    },
  },
  mounted() {
    console.log("created!!!!!", this.userInfo);
  },
  methods: {
    ...mapMutations(userStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    ...mapMutations(qnaStore, ["SET_MY_QNA_LIST"]),
    toggleSidebar() {
      this.$sidebar.displaySidebar(!this.$sidebar.showSidebar);
    },
    toggleMenu() {
      this.showMenu = !this.showMenu;
    },
    profile() {
      this.$router.push({ name: "User Profile" });
    },
    login() {
      this.$router.push({ name: "UserLogin" });
    },
    join() {
      this.$router.push({ name: "UserJoin" });
    },
    logout() {
      this.SET_IS_LOGIN(false);
      this.SET_USER_INFO(null);
      this.SET_MY_QNA_LIST(null);
      sessionStorage.removeItem("access-token");
      //홈으로 일단은 dashboard로 가게 해둠
      this.$router.push({ name: "Dashboard" });
    },
    goHome() {
      this.$router.push({ name: "Dashboard" });
    },
  },
};
</script>
<style></style>
