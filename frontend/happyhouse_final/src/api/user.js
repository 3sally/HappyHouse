import { apiInstance } from "./index.js";

const api = apiInstance();

async function login(user, success, fail) {
  await api
    .post(`user/login`, JSON.stringify(user))
    .then(success)
    .catch(fail);
}

async function findById(userid, success, fail) {
  api.defaults.headers["access-token"] = sessionStorage.getItem("access-token");
  await api
    .get(`user/info/${userid}`)
    .then(success)
    .catch(fail);
}

// function logout(success, fail)

function join(user, success, fail) {
  // console.log("join user->", user);
  api
    .post("user/join", user)
    .then(success)
    .catch(fail);
}

function deleteUser(userid, success, fail) {
  // console.log("Delete ", userid);
  api
    .delete("user/delete/" + userid)
    .then(success)
    .catch(fail);
}

function modify(user, success, fail) {
  api
    .put("user/modify", user)
    .then(success)
    .catch(fail);
}

async function checkID(id, success, fail) {
  // console.log("checkID -> ", id.ckid);
  const params = id;
  api
    .get("user/idcheck", { params })
    .then(success)
    .catch(fail);
}

function getinterestArea(userid, success, fail) {
  // console.log("getinterestArea user~! ->", userid);
  const params = userid;
  api
    .get("user/getArea", { params })
    .then(success)
    .catch(fail);
}

function modifyArea(data, success, fail) {
  // console.log("modifyArea -> ", data);
  api
    .put("user/changeInterestArea", data)
    .then(success)
    .catch(fail);
}

function userList(success, fail) {
  api
    .get("user")
    .then(success)
    .catch(fail);
}
export {
  login,
  findById,
  join,
  deleteUser,
  modify,
  checkID,
  getinterestArea,
  modifyArea,
  userList,
};
