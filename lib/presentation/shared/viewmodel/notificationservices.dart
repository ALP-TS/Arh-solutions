// // import 'dart:async';
// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:platform/platform.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:timezone/timezone.dart';
// import 'package:timezone/timezone.dart' as tz;

// class NotificationService {
//   // Singleton pattern
//   static final NotificationService _instance = NotificationService._internal();
//   factory NotificationService() => _instance;
//   NotificationService._internal();

//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Notification channel IDs
//   static const String _channelId = 'high_importance_channel';
//   static const String _channelName = 'Important Notifications';
//   static const String _channelDesc = 'Channel for important notifications';

//   Future<void> initialize() async {
//     try {
//       tz.initializeTimeZones();
//       final location = tz.getLocation('Asia/Kolkata');
//       tz.setLocalLocation(location);
//       const AndroidInitializationSettings androidSettings =
//           AndroidInitializationSettings('@mipmap/ic_launcher');

//       const DarwinInitializationSettings iosSettings =
//           DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//       );

//       await _notificationsPlugin.initialize(
//         const InitializationSettings(
//           android: androidSettings,
//           iOS: iosSettings,
//         ),
//         onDidReceiveNotificationResponse: _onNotificationTap,
//       );

//       await _createNotificationChannel();
//       debugPrint('Notification service initialized');
//     } catch (e) {
//       debugPrint('Error initializing notifications: $e');
//     }
//   }

//   Future<void> _createNotificationChannel() async {
//     if (const LocalPlatform().isAndroid) {
//       AndroidNotificationChannel channel = AndroidNotificationChannel(
//         _channelId,
//         _channelName,
//         description: _channelDesc,
//         importance: Importance.max,
//         playSound: true,
//         sound: RawResourceAndroidNotificationSound('notification'),
//         enableVibration: true,
//         vibrationPattern: Int64List.fromList([0, 500, 1000, 500]),
//       );

//       await _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);
//     }
//   }

//   Future<bool> _requestPermissions() async {
//     if (const LocalPlatform().isAndroid) {
//       final androidInfo = await DeviceInfoPlugin().androidInfo;
//       if (androidInfo.version.sdkInt >= 33) {
//         final status = await Permission.notification.request();
//         return status.isGranted;
//       }
//       return true;
//     } else if (const LocalPlatform().isIOS) {
//       final result = await _notificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//       return result ?? false;
//     }
//     return false;
//   }

// Future<void> scheduleNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledDate,
//     String? payload,
//     NotificationDetails? notificationDetails,
//   }) async {
//     try {
//       final hasPermission = await _requestPermissions();
//       if (!hasPermission) return;

//       final details = notificationDetails ??
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               _channelId,
//               _channelName,
//               channelDescription: _channelDesc,
//               importance: Importance.max,
//               priority: Priority.high,
//               playSound: true,
//             ),
//             iOS: DarwinNotificationDetails(
//               sound: 'default',
//               presentAlert: true,
//               presentBadge: true,
//               presentSound: true,
//             ),
//           );

//       await _notificationsPlugin.zonedSchedule(
//         id,
//         title,
//         body,
//         _scheduleTimeZone(scheduledDate),
//         details,
//         payload: payload,
//         androidAllowWhileIdle: true, // To ensure notification shows even in doze mode
//         uiLocalNotificationDateInterpretation: 
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time, // For daily repeating if needed
//       );
//     } catch (e) {
//       debugPrint('Error scheduling notification: $e');
//     }
//   }

//   TZDateTime _scheduleTimeZone(DateTime dateTime) {
//     // Convert to local timezone (or your preferred timezone)
//     // You'll need to import the timezone package:
//     // import 'package:timezone/timezone.dart' as tz;
//     // import 'package:timezone/data/latest.dart' as tz;
//     return TZDateTime.from(dateTime, tz.local);
//   }
//   Future<void> showInstantNotification({
//     required int id,
//     required String title,
//     required String body,
//     String? payload,
//     NotificationDetails? notificationDetails,
//   }) async {
//     try {
//       final hasPermission = await _requestPermissions();
//       if (!hasPermission) return;

//       final details = notificationDetails ??
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               _channelId,
//               _channelName,
//               channelDescription: _channelDesc,
//               importance: Importance.max,
//               priority: Priority.high,
//               playSound: true,
//             ),
//             iOS: DarwinNotificationDetails(
//               sound: 'default',
//               presentAlert: true,
//               presentBadge: true,
//               presentSound: true,
//             ),
//           );

//       await _notificationsPlugin.show(id, title, body, details,
//           payload: payload);
//     } catch (e) {
//       debugPrint('Error showing instant notification: $e');
//     }
//   }

//   Future<void> cancelNotification(int id) async {
//     await _notificationsPlugin.cancel(id);
//   }

//   Future<void> cancelAllNotifications() async {
//     await _notificationsPlugin.cancelAll();
//   }

//   void _onNotificationTap(NotificationResponse response) {
//     debugPrint('Notification tapped: ${response.payload}');
//     // Handle notification tap (e.g., navigate to specific screen)
//   }

//   Future<List<PendingNotificationRequest>> getPendingNotifications() async {
//     return await _notificationsPlugin.pendingNotificationRequests();
//   }
// }
