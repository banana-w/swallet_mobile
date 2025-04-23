import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/notification_model.dart';
import 'package:swallet_mobile/main.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_screen.dart';

class NotificationService {
  // Singleton pattern
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  // Firebase Messaging instance
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Local notifications plugin
  final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  // Flag to track initialization status
  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    try {
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Request notification permissions
      await requestPermission();

      // Setup message handler
      await setupMessageHandler();

      final token = await _messaging.getToken();
      print('FCM Token: $token');

      final settings = await _messaging.getNotificationSettings();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        final student = await AuthenLocalDataSource.getStudent();
        if (student != null && student.id.isNotEmpty) {
          await loginStudent(student.id);
        }
      }
    } catch (e) {
      print('Error initializing NotificationService: $e');
    }
  }

  Future<void> requestPermission() async {
    try {
      // Request notification permissions
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
      );

      // Print permission status
      print('Permission status: ${settings.authorizationStatus}');

      // Initialize local notifications if not already initialized
      if (!isFlutterLocalNotificationsInitialized) {
        await _initLocalNotifications();
      }
    } catch (e) {
      print('Error requesting permission: $e');
    }
  }

  Future<void> _initLocalNotifications() async {
    try {
      // android setup
      const channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );
      await localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      // Android initialization settings
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // iOS initialization settings
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      // Combined initialization settings
      const initializationSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      // Initialize the plugin
      await localNotifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          // Handle notification tap
          print('Notification tapped: ${details.payload}');
          onNotificationTap(details);
        },
      );
      isFlutterLocalNotificationsInitialized = true;
    } catch (e) {
      print('Error initializing local notifications: $e');
    }
  }

  static void onNotificationTap(NotificationResponse notificationResponse) {
    navigatorKey.currentState!.pushNamed(
      NotificationScreen.routeName,
      arguments: notificationResponse,
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    try {
      if (!isFlutterLocalNotificationsInitialized) {
        await _initLocalNotifications();
      }

      const androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await localNotifications.show(
        message.messageId.hashCode, // Use message ID as notification ID
        message.notification?.title ?? 'Notification',
        message.notification?.body ?? '',
        platformDetails,
        payload: jsonEncode(message.data),
      );
      notificationBloc.add(
        AddNewNotification(
          notificationModel: NotificationModel(
            title: message.notification?.title ?? 'Notification',
            body: message.notification?.body ?? '',
            payload: jsonEncode(message.data),
          ),
        ),
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  Future<void> setupMessageHandler() async {
    try {
      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Received foreground message: ${message.messageId}');
        showNotification(message);
      });

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Handle when app is opened from a terminated state
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print('App opened from terminated state: ${initialMessage.messageId}');
        showNotification(initialMessage);
      }

      // Handle when app is opened from background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // showNotification(message);
        if (message.notification != null) {
          print('Backgroud Notification Tapped');
          navigatorKey.currentState!.pushNamed(
            NotificationScreen.routeName,
            arguments: message,
          );
        }
      });
    } catch (e) {
      print('Error setting up message handler: $e');
    }
  }

  Future<void> subribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic: $e');
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Error unsubscribing from topic: $e');
    }
  }

  String? _currentStudentId;

  Future<void> logoutStudent() async {
    try {
      if (_currentStudentId != null) {
        await unsubscribeFromTopic(_currentStudentId!);
        _currentStudentId = null;
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  Future<void> loginStudent(String studentId) async {
    try {
      if (_currentStudentId == studentId) {
        print('Already subscribed to topic: $studentId');
        return;
      }
      // Unsubscribe khỏi topic cũ nếu có
      if (_currentStudentId != null && _currentStudentId != studentId) {
        await unsubscribeFromTopic(_currentStudentId!);
      }
      // Subscribe vào topic mới
      await subribeToTopic(studentId);
      _currentStudentId = studentId;
    } catch (e) {
      print('Error switching student topic: $e');
    }
  }
}

final notificationBloc = NotificationBloc();

// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling background message: ${message.messageId}');
  // Note: Background messages don't show notifications automatically
  // You can call showNotification here if needed, but ensure NotificationService is properly initialized
  await NotificationService.instance._initLocalNotifications();
  // await NotificationService.instance.showNotification(message);

  if (message.notification != null) {
    print('Some notification Received!');
    notificationBloc.add(
      AddNewNotification(
        notificationModel: NotificationModel(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: jsonEncode(message.data),
        ),
      ),
    );
  }
}
