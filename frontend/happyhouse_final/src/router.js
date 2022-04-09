import Vue from "vue";
import VueRouter from "vue-router";

import DashboardLayout from "@/pages/Layout/DashboardLayout.vue";

import Dashboard from "@/pages/Dashboard.vue";
import Icons from "@/pages/Icons.vue";
import Maps from "@/pages/Maps.vue";
import Notifications from "@/pages/Notifications.vue";
import UserProfile from "@/pages/UserProfile.vue";
import TableList from "@/pages/TableList.vue";
import Typography from "@/pages/Typography.vue";
import UpgradeToPRO from "@/pages/UpgradeToPRO.vue";

//user
import User from "@/pages/User.vue";
import UserLogin from "@/components/user/UserLogin.vue";
import UserJoin from "@/components/user/UserJoin.vue";
import UserMyPage from "@/components/user/UserMyPage.vue";
import UserDelete from "@/components/user/UserDelete.vue";
import UserModify from "@/components/user/UserModify.vue";
import UserList from "@/components/user/UserList.vue";

// qna
import QnA from "@/pages/QnA.vue";
import QnAList from "@/components/QnA/QnAList.vue";
import QnACreate from "@/components/QnA/QnACreate.vue";
import QnAModify from "@/components/QnA/QnAModify.vue";
import QnADetail from "@/components/QnA/QnADetail.vue";
import QnADelete from "@/components/QnA/QnADelete.vue";

// notice
import Notice from "@/pages/Notice.vue";
import NoticeList from "@/components/notice/NoticeList.vue";
import NoticeCreate from "@/components/notice/NoticeCreate.vue";
import NoticeModify from "@/components/notice/NoticeModify.vue";
import NoticeDetail from "@/components/notice/NoticeDetail.vue";
import NoticeDelete from "@/components/notice/NoticeDelete.vue";

import store from "@/store/index.js";

Vue.use(VueRouter);

// https://router.vuejs.org/kr/guide/advanced/navigation-guards.html
const onlyAuthUser = async (to, from, next) => {
  // console.log(store);
  const checkUserInfo = store.getters["userStore/checkUserInfo"];
  const getUserInfo = store._actions["userStore/getUserInfo"];
  let token = sessionStorage.getItem("access-token");
  if (checkUserInfo == null && token) {
    await getUserInfo(token);
  }
  if (checkUserInfo === null) {
    alert("로그인이 필요한 페이지입니다..");
    // next({ name: "SignIn" });
    router.push({ name: "UserLogin" });
  } else {
    // console.log("로그인 했다.");
    next();
  }
};

const routes = [
  {
    path: "/",
    component: DashboardLayout,
    redirect: "dashboard",
    children: [
      {
        path: "dashboard",
        name: "Dashboard",
        component: Dashboard,
      },
      {
        path: "maps",
        name: "Maps",
        component: Maps,
      },
      {
        path: "user",
        name: "User Profile",
        component: UserProfile,
      },
      {
        path: "/user",
        name: "User",
        component: User,
        redirect: "/user/login",
        children: [
          {
            path: "login",
            name: "UserLogin",
            component: UserLogin,
          },
          {
            path: "join",
            name: "UserJoin",
            component: UserJoin,
          },
          {
            path: "list",
            name: "UserList",
            beforeEnter: onlyAuthUser,
            component: UserList,
          },
          {
            path: "mypage/:id",
            name: "UserMyPage",
            beforeEnter: onlyAuthUser,
            component: UserMyPage,
          },
          {
            path: "delete/:id",
            name: "UserDelete",
            beforeEnter: onlyAuthUser,
            component: UserDelete,
          },
          {
            path: "modify/:id",
            name: "UserModify",
            beforeEnter: onlyAuthUser,
            component: UserModify,
          },
        ],
      },
      {
        path: "/qna",
        name: "QnA",
        component: QnA,
        redirect: "/qna/list",
        children: [
          {
            path: "list",
            name: "QnAList",
            component: QnAList,
          },
          {
            path: "create",
            name: "QnACreate",
            beforeEnter: onlyAuthUser,
            component: QnACreate,
          },
          {
            path: "modify/:no",
            name: "QnAModify",
            beforeEnter: onlyAuthUser,
            component: QnAModify,
          },
          {
            path: "detail/:no",
            name: "QnADetail",
            beforeEnter: onlyAuthUser,
            component: QnADetail,
          },
          {
            path: "delete/:no",
            name: "QnADelete",
            beforeEnter: onlyAuthUser,
            component: QnADelete,
          },
        ],
      },
      {
        path: "/notice",
        name: "Notice",
        component: Notice,
        redirect: "/notice/list",
        children: [
          {
            path: "list",
            name: "NoticeList",
            component: NoticeList,
          },
          {
            path: "create",
            name: "NoticeCreate",
            beforeEnter: onlyAuthUser,
            component: NoticeCreate,
          },
          {
            path: "modify/:no",
            name: "NoticeModify",
            beforeEnter: onlyAuthUser,
            component: NoticeModify,
          },
          {
            path: "detail/:no",
            name: "NoticeDetail",
            beforeEnter: onlyAuthUser,
            component: NoticeDetail,
          },
          {
            path: "delete/:no",
            name: "NoticeDelete",
            beforeEnter: onlyAuthUser,
            component: NoticeDelete,
          },
        ],
      },
    ],
  },
];

const router = new VueRouter({
  mode: "history",
  routes,
  linkExactActiveClass: "active",
});

export default router;
