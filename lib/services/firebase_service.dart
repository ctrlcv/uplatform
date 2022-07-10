import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/components/message_notification.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/user_model.dart';
import 'package:uplatform/page/common/alarm_list_page.dart';
import 'package:overlay_support/overlay_support.dart';

import 'login_service.dart';
import 'network.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Handling a background message');

  if (UniversalPlatform.isAndroid) {
    // FirebaseService().showNotification(message);
  }
  return Future.value(null);
}

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._internal();

  late AndroidNotificationChannel channel;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  late Stream<String> _tokenStream;

  factory FirebaseService() {
    return _singleton;
  }

  FirebaseService._internal() {
    debugPrint('FirebaseService(Singleton) was created.');
  }

  Future<void> initialize() async {
    debugPrint('FirebaseService - initialize()');

    if (UniversalPlatform.isWeb) {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          name: "syniyo",
          options: const FirebaseOptions(
            apiKey: "AIzaSyCGpYRLh9dISfCoKDft21cXQCcbFX5y0xc",
            authDomain: "shinyo-c01b5.firebaseapp.com",
            databaseURL: "https://finders-975fe-default-rtdb.firebaseio.com",
            projectId: "shinyo-c01b5",
            storageBucket: "shinyo-c01b5.appspot.com",
            messagingSenderId: "771233978513",
            appId: "1:771233978513:web:7759225b0f21dabdb60730",
            measurementId: "G-WPZBHPEC7W",
          ),
        );
      } else {
        Firebase.app();
      }
    } else {
      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      channel = const AndroidNotificationChannel(
        'uplatform_channel_id',
        'uplatform_Notifications',
        description: 'This channel is used for important notifications in uplatform',
        importance: Importance.max,
      );

      var androidSetting = const AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosSetting = const IOSInitializationSettings();

      var initializationSettings = InitializationSettings(android: androidSetting, iOS: iosSetting);
      flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then((var message) async {
      debugPrint("FirebaseService().onMessage() getInitialMessage()");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint("FirebaseService().onMessage() onMessage() $message");

      RemoteNotification? notification = message.notification;
      debugPrint("FirebaseService().onMessage() notification ${notification!.body}");

      if (UniversalPlatform.isWeb) {
        if (notification != null) {
          showOverlay((context, t) {
            return FractionalTranslation(
              translation: const Offset(0, 0),
              child: Column(
                children: <Widget>[
                  MessageNotification(
                    message: notification.body ?? "",
                    onPress: () {
                      Get.toNamed(AlarmListPage.routeName);
                    },
                    key: ModalKey(const Object()),
                  ),
                ],
              ),
            );
          }, duration: Duration.zero);
        }
      } else if (!UniversalPlatform.isIOS) {
        showNotification(message);
      }

      await LoginService().calcUnReadAlarmCount();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('A new onMessageOpenedApp event was published!');
      Get.toNamed(AlarmListPage.routeName);
    });

    initToken();
  }

  void initToken() {
    debugPrint('FirebaseService().initToken()');

    LoginUser? loginUser = LoginService().getLoginUser();

    if (loginUser == null) {
      debugPrint('FirebaseService().initToken(), loginUser is NULL');
      return;
    }

    debugPrint('FirebaseService().getToken()');

    FirebaseMessaging.instance.getToken().then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  void setToken(String? token) async {
    if (token == null) {
      debugPrint('FirebaseService().setToken() token is NULL, return');
      return;
    }

    CommonResponse? response = await Network().updateFcmToken(token);

    if (response != null && response.status == "200") {
      debugPrint('FirebaseService().setToken() updateToken success : $token');
    } else {
      debugPrint('FirebaseService().setToken() updateToken fail: $token');
    }
  }

  Future onSelectNotification(String? payload) async {
    debugPrint("FirebaseService().onSelectNotification() payload: $payload!");

    Get.toNamed(AlarmListPage.routeName);
  }

  Future showNotification(RemoteMessage message) async {
    flutterLocalNotificationsPlugin.cancelAll();

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      color: Colors.transparent,
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iosPlatformChannelSpecifics = const IOSNotificationDetails(sound: 'slow_spring.board.aiff');
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iosPlatformChannelSpecifics);

    var notification = message.notification;
    var data = message.data;
    String? title = notification!.title ?? "";
    String? body = notification.body ?? "";

    await flutterLocalNotificationsPlugin.show(
      1000,
      title,
      body,
      platformChannelSpecifics,
      payload: "",
    );
  }

  void cancelScheduleNotification() {
    flutterLocalNotificationsPlugin.cancel(1001);
  }
}
