import {
  noticeList,
  noticeDetail,
  noticeDelete,
  noticeCreate,
  noticeModify,
  updateViews,
  hotNoticeList,
} from "@/api/notice.js";

const noticeStore = {
  namespaced: true,
  state: {
    notices: [],
    hotnotices: [],
    notice: null,
  },
  mutations: {
    SET_NOTICE_LIST(state, notices) {
      state.notices = notices;
    },
    SET_NOTICE_DETAIL(state, notice) {
      state.notice = notice;
    },
    SET_HOT_NOTICE_LIST(state, notice) {
      state.hotnotices = notice;
    },
  },
  actions: {
    getNoticeList: ({ commit }) => {
      // console.log("noticeStore => noticeList");
      noticeList(
        (response) => {
          console.log(response.data);
          commit("SET_NOTICE_LIST", response.data);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    getNoticeDetail: ({ commit }, aritlceNo) => {
      noticeDetail(
        aritlceNo,
        (response) => {
          commit("SET_NOTICE_DETAIL", response.data);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    deleteNotice: ({ commit }, aritlceNo) => {
      // console.log("noticeStore => deleteNotice");
      noticeDelete(
        aritlceNo,
        (response) => {
          console.log(commit, response);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    createNotice: ({ commit }, notice) => {
      const params = notice;
      noticeCreate(
        params,
        (response) => {
          console.log(commit, response);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    modifyNotice: ({ commit }, data) => {
      const params = {
        articleNo: data.no,
        userId: data.notice.userId,
        subject: data.notice.subject,
        content: data.notice.content,
      };
      noticeModify(
        params,
        (response) => {
          console.log(commit, response);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    increaseViews: ({ commit }, aritlceNo) => {
      updateViews(
        aritlceNo,
        (response) => {
          console.log(commit, response);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    getHotNoticeList: ({ commit }) => {
      hotNoticeList(
        (response) => {
          console.log("hotNoticeList", response.data);
          commit("SET_HOT_NOTICE_LIST", response.data);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
  },
};

export default noticeStore;
