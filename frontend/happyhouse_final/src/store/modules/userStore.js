import jwt_decode from "jwt-decode";
import {
  login,
  findById,
  join,
  deleteUser,
  modify,
  getinterestArea,
  modifyArea,
  checkID,
  userList,
} from "@/api/user.js";

const userStore = {
  namespaced: true,
  state: {
    isLogin: false,
    isLoginError: false,
    userInfo: null,
    userInterestArea: null,
    idcount: null,
    users: [],
  },
  getters: {
    checkUserInfo: function(state) {
      return state.userInfo;
    },
  },
  mutations: {
    SET_IS_LOGIN: (state, isLogin) => {
      state.isLogin = isLogin;
    },
    SET_IS_LOGIN_ERROR: (state, isLoginError) => {
      state.isLoginError = isLoginError;
    },
    SET_USER_INFO: (state, userInfo) => {
      state.isLogin = true;
      state.userInfo = userInfo;
      console.log("SET_USER_INFO : userInfo =>", state.userInfo);
    },
    UPDATE_USER_INFO: (state, userInfo) => {
      state.userInfo = userInfo;
    },
    USER_INTEREST_AREA: (state, data) => {
      state.userInterestArea = data;
    },
    ID_COUNT: (state, idcount) => {
      state.idcount = idcount;
    },
    INITIAL_IDCOUNT: (state, value) => {
      state.idcount = value;
    },
    SET_USERS: (state, users) => {
      state.users = users;
    },
  },
  actions: {
    async userConfirm({ commit }, user) {
      // console.log("userStore -> user : ", user);
      await login(
        user,
        (response) => {
          if (response.data.message === "success") {
            let token = response.data["access-token"];
            commit("SET_IS_LOGIN", true);
            commit("SET_IS_LOGIN_ERROR", false);
            sessionStorage.setItem("access-token", token);
          } else {
            commit("SET_IS_LOGIN", false);
            commit("SET_IS_LOGIN_ERROR", true);
          }
        },
        () => {}
      );
    },
    getUserInfo({ commit }, token) {
      let decode_token = jwt_decode(token);
      findById(
        decode_token.userid,
        (response) => {
          if (response.data.message === "success") {
            commit("SET_USER_INFO", response.data.userInfo);
          } else {
            console.log("유저 정보 없음!!");
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
    userJoin({ commit }, user) {
      // console.log("userJoin : user -> ", user);
      join(
        user,
        (response) => {
          console.log("회원가입 성공", response);
        },
        (error) => {
          console.log("error : ", error);
        }
      );
    },
    userDelete({ commit }, userId) {
      // console.log("deleteUser : userId -> ", userId);
      deleteUser(
        userId,
        (response) => {
          console.log("회원탈퇴 성공", response);
        },
        (error) => {
          console.log("error : ", error);
        }
      );
    },
    updateUser({ commit }, user) {
      // console.log("updateUser -> ", user);
      modify(
        user,
        (response) => {
          commit("UPDATE_USER_INFO", response.data.userInfo);
          // console.log("정보수정 성공", response);
        },
        (error) => {
          console.log("error : ", error);
        }
      );
    },
    IdCheck({ commit }, id) {
      // console.log("[userStore] idCheck -> ", id);
      checkID(
        id,
        (response) => {
          commit("ID_COUNT", response.data.idcount);
          // console.log("아이디 중복검사 중", response.data.idcount);
        },
        (error) => {
          console.log("error : ", error);
        }
      );
    },
    getUserInterestArea({ commit }, userId) {
      // console.log("getUserInterestArea userid-> ", userId);
      getinterestArea(
        userId,
        (response) => {
          // console.log("가져오기 성공", response.data);
          commit("USER_INTEREST_AREA", response.data);
        },
        (error) => {
          console.log("error : ", error);
        }
      );
    },
    modifyInterestArea({ commit }, data) {
      // console.log("modifyArea -> ", data);
      modifyArea(
        data,
        (response) => {
          console.log("관심지역 변경 성공", response);
        },
        (error) => {
          console.log("error : ", error);
        }
      );
    },
    getUserList({ commit }) {
      userList(
        (response) => {
          // console.log("getUserList => ", response.data);
          commit("SET_USERS", response.data);
        },
        (error) => {
          console.log("error : ", error);
        }
      );
    },
  },
};

export default userStore;
