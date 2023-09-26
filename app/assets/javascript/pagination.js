
// adminユーザがページネーションを使い遷移した場合にurlにadminを保持できるようにする
window.onload = addAdminToURL;

function addAdminToURL(){
  let pagination_url = document.getElementsByClassName('page-link');
  let current_path_name = location.pathname;
  if (current_path_name.match(/admin/)){
    for (let i = 0; i < pagination_url.length; i++){
      let href = pagination_url[i].href;
      href = href.replace('/items', '/admin/items');
      pagination_url[i].href = href
      pagination_url[i].setAttribute("onClick", 'addAdminToURLBridge()');
  }
  }
}

function addAdminToURLBridge(){
  let pagination_url = document.getElementsByClassName('page-link');
  let current_path_name = location.pathname;
  if (current_path_name.match(/admin/)){
    for (let i = 0; i < pagination_url.length; i++){
      pagination_url[i].setAttribute("onClick", 'addAdminToURLBridge()');
    }
  }
  window.setTimeout(addAdminToURL, 1000)
}