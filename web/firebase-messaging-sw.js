// console.log("")
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");
firebase.initializeApp({
  apiKey: "AIzaSyCGpYRLh9dISfCoKDft21cXQCcbFX5y0xc",
  authDomain: "shinyo-c01b5.firebaseapp.com",
  databaseURL: "https://finders-975fe-default-rtdb.firebaseio.com",
  projectId: "shinyo-c01b5",
  storageBucket: "shinyo-c01b5.appspot.com",
  messagingSenderId: "771233978513",
  appId: "1:771233978513:web:7759225b0f21dabdb60730",
  measurementId: "G-WPZBHPEC7W",
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});

self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});