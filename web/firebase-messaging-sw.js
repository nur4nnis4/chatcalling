importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyBBQzzyiUE0jGDbOOrwvQq0ZvXvbYUTy7o',
  appId: '1:820559575255:web:bf52538621ffe56b1b5892',
  messagingSenderId: '820559575255',
  projectId: 'chatcalling-63eb0',
  authDomain: 'chatcalling-63eb0.firebaseapp.com',
  databaseURL: 'https://chatcalling-63eb0-default-rtdb.asia-southeast1.firebasedatabase.app',
  storageBucket: 'chatcalling-63eb0.appspot.com',
  measurementId: 'G-KKBY57NSMV',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});