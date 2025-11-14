// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart';
// import 'package:timezone/data/latest.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class NotificationService {
  

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   bool initialized = false;
//   bool get isInitialized => initialized;

//   Future<void> init() async {
//     if (isInitialized) return;
//     initializeTimeZones();
// setLocalLocation(getLocation('America/Argentina/San_Juan'));
//     // Confirguración inicial para Android
//     const AndroidInitializationSettings initializationSettingsAndroid =
// AndroidInitializationSettings('@mipmap/ic_launcher');
// final DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//           requestAlertPermission: true,
//           requestBadgePermission: true,
//           requestSoundPermission: true,
//         );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//           android: initializationSettingsAndroid,
//           iOS: initializationSettingsIOS,
//         );
//     await Permission.notification.request();
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     initialized = true;
//   }
// NotificationDetails notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'your_channel_id',
//         'your_channel_name',
//         channelDescription: 'your_channel_description',
//         importance: Importance.max,
//         priority: Priority.high,
//         showWhen: false,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );
//   }
// Future<void> showInstantNotification({
//     int id = 0,
//     String? title,
//     String? body,
//   }) async {
//     if (!isInitialized) {
//       await init();
//     }
//     return flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       notificationDetails(),
//     );
//   }
// Future<void> showScheduledNotification({
//     int id = 0,
//     String? title,
//     String? body,
//   }) async {
//     if (!isInitialized) {
//       await init();
//     }
//     return flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       TZDateTime.now(local).add(const Duration(seconds: 5)),
//       notificationDetails(),
//       androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
//       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
//     );
//   }
//   }