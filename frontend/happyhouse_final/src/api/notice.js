import { apiInstance } from "./index.js";

const api = apiInstance();

function noticeList(success, fail) {
  api
    .get("notice")
    .then(success)
    .catch(fail);
}

function noticeDetail(aritlceNo, success, fail) {
  api
    .get("notice/" + aritlceNo)
    .then(success)
    .catch(fail);
}

function noticeDelete(aritlceNo, success, fail) {
  api
    .delete("notice/" + aritlceNo)
    .then(success)
    .catch(fail);
}

function noticeCreate(params, success, fail) {
  api
    .post("notice", params)
    .then(success)
    .catch(fail);
}

function noticeModify(params, success, fail) {
  api
    .put("notice", params)
    .then(success)
    .catch(fail);
}

function updateViews(articleNo, success, fail) {
  api
    .put("notice/" + articleNo)
    .then(success)
    .catch(fail);
}

function hotNoticeList(success, fail) {
  api
    .get("notice/hot")
    .then(success)
    .catch(fail);
}

export {
  noticeList,
  noticeDetail,
  noticeDelete,
  noticeCreate,
  noticeModify,
  updateViews,
  hotNoticeList,
};
