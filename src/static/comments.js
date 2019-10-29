var firebaseConfig = {
  apiKey: "AIzaSyD3E0XtiUJI4-JIxcIPZziNLGVaTdojz20",
  authDomain: "mitja-felicijan-blog.firebaseapp.com",
  databaseURL: "https://mitja-felicijan-blog.firebaseio.com",
  projectId: "mitja-felicijan-blog",
  storageBucket: "mitja-felicijan-blog.appspot.com",
  messagingSenderId: "41650892882",
  appId: "1:41650892882:web:b308f0a9c47198bdf7ef8b"
};
firebase.initializeApp(firebaseConfig);

var database = firebase.database();
var docPath = window.location.hostname.replace('.', '-') + '/comments' + window.location.pathname.replace('.html', '');
var submit = document.querySelector('#submit');
var comments = document.querySelector('.comments ul');
var textName = document.querySelector('#name');
var textComment = document.querySelector('#comment');
var ref = firebase.database().ref(docPath);

function encodeHTML(s) {
  return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/"/g, '&quot;');
}

if (submit) {
  ref.on("value", function (snapshot) {
    comments.innerHTML = '';
    var commentList = Array();

    // generating normal array
    snapshot.forEach(function (item) {
      commentList.push(item.val())
    });

    // rendering html
    commentList.reverse().forEach(function (item) {
      var liItem = `<li>
          <div><b>${encodeHTML(item.name)}</b> - ${encodeHTML(item.published)}</div>
          <div>${encodeHTML(item.comment)}</div>
        </li>`;
      comments.innerHTML += liItem;
    });

  }, function (errorObject) {
    console.log("The read failed: " + errorObject.code);
  });

  submit.addEventListener('click', function (evt) {
    if (textName.value && textComment.value) {
      submit.disabled = true;
      firebase.database().ref(docPath + '/' + Date.now()).set({
        name: textName.value,
        comment: textComment.value,
        published: new Date().toISOString().slice(0, 16).replace('T', ' '),
      }, function (error) {
        if (error) {
          alert('Data could not be saved.' + error);
        } else {
          textName.value = '';
          textComment.value = '';
          submit.disabled = false;
        }
      });
    }
  });
}
