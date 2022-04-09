import {
  qnaList,
  myQnaList,
  qnaDetail,
  qnaDelete,
  qnaCreate,
  qnaModify,
  qnaGetComment,
  qnaSetComment,
  qnaChangeComment,
  qnaDeleteComment,
} from "@/api/qna.js";

const qnaStore = {
  namespaced: true,
  state: {
    qnas: [],
    myqnas: [],
    qna: null,
    comment: null,
  },
  mutations: {
    SET_QNA_LIST(state, qnas) {
      state.qnas = qnas;
      // console.log("state.qnas -> ", state.qnas);
    },
    SET_QNA_DETAIL(state, qna) {
      state.qna = qna;
    },
    SET_COMMENT(state, comment) {
      state.comment = comment;
    },
    SET_MY_QNA_LIST(state, myqnas) {
      state.myqnas = myqnas;
    },
  },
  actions: {
    getQnAList: ({ commit }) => {
      qnaList(
        (response) => {
          commit("SET_QNA_LIST", response.data);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    getQnADetail: ({ commit }, qnaNo) => {
      qnaDetail(
        qnaNo,
        (response) => {
          // console.log("getQnADetail!!!", response.data);
          commit("SET_QNA_DETAIL", response.data);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    getMyQnAList: ({ commit }, userId) => {
      // console.log("getMyQnAList =>", userId);
      myQnaList(
        userId,
        (response) => {
          commit("SET_MY_QNA_LIST", response.data);
        },
        (error) => {
          console.log("error =>", error);
        }
      );
    },
    deleteQnA: ({ commit }, qnaNo) => {
      qnaDelete(
        qnaNo,
        (response) => {
          console.log(commit, response);
          // console.log("deleteQnA!!!", commit, response.data);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    createQnA: ({ commit }, qna) => {
      const params = {
        userId: qna.userId,
        title: qna.title,
        content: qna.content,
      };
      qnaCreate(
        params,
        (response) => {
          console.log(commit, response);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    modifyQnA: ({ commit }, data) => {
      const params = {
        qnaNo: data.no,
        userId: data.qna.userId,
        title: data.qna.title,
        content: data.qna.content,
      };
      qnaModify(
        params,
        (response) => {
          console.log(commit, response);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    getComment: ({ commit }, qnaNo) => {
      // console.log("getComment -> " + qnaNo);
      qnaGetComment(
        qnaNo,
        (response) => {
          commit("SET_COMMENT", response.data[0]);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    setComment: ({ commit }, data) => {
      // console.log(data);
      qnaSetComment(
        data,
        (response) => {
          console.log(commit, response);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    changeComment: ({ commit }, data) => {
      qnaChangeComment(
        data,
        (response) => {
          console.log(commit, response);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
    delComment: ({ commit }, qnaNo) => {
      qnaDeleteComment(
        qnaNo,
        (response) => {
          console.log(commit, response);
        },
        (error) => {
          console.log("error -> " + error);
        }
      );
    },
  },
};

export default qnaStore;
