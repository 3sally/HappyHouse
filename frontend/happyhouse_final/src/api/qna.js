import { apiInstance } from "./index.js";

const api = apiInstance();

function qnaList(success, fail) {
  api
    .get("qna")
    .then(success)
    .catch(fail);
}

function myQnaList(userId, success, fail) {
  console.log("userId's QnaList=> " + userId);
  api
    .get("qna/myqna/" + userId)
    .then(success)
    .catch(fail);
}

function qnaDetail(qnaNo, success, fail) {
  api
    .get("qna/" + qnaNo)
    .then(success)
    .catch(fail);
}

function qnaDelete(qnaNo, success, fail) {
  api
    .delete("qna/" + qnaNo)
    .then(success)
    .catch(fail);
}

function qnaCreate(params, success, fail) {
  api
    .post("qna", params)
    .then(success)
    .catch(fail);
}

function qnaModify(params, success, fail) {
  api
    .put("qna", params)
    .then(success)
    .catch(fail);
}

function qnaGetComment(qnaNo, success, fail) {
  console.log("qnaGetComment -> " + qnaNo);
  api
    .get("comment/" + qnaNo)
    .then(success)
    .catch(fail);
}

function qnaSetComment(data, success, fail) {
  api
    .post("comment", data)
    .then(success)
    .catch(fail);
}

function qnaChangeComment(data, success, fail) {
  api
    .put("comment", data)
    .then(success)
    .catch(fail);
}

function qnaDeleteComment(qnaNo, success, fail) {
  api
    .delete("comment/" + qnaNo)
    .then(success)
    .catch(fail);
}
export {
  qnaList,
  qnaDetail,
  qnaDelete,
  qnaCreate,
  qnaModify,
  qnaGetComment,
  qnaSetComment,
  myQnaList,
  qnaChangeComment,
  qnaDeleteComment,
};
