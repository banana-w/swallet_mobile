import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/notification_model.dart';
import 'package:swallet_mobile/data/repositories/student_features/student_repository_imp.dart';
import 'package:swallet_mobile/main.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/notification/notification_screen.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _studentRepository = StudentRepositoryImp();
  final FlutterLocalNotificationsPlugin localNotifications = FlutterLocalNotificationsPlugin();
  bool isFlutterLocalNotificationsInitialized = false;
  String? _currentStudentId;

  Future<void> initialize() async {
    try {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      if (!isFlutterLocalNotificationsInitialized) {
        await _initLocalNotifications();
      }
      
      // Request quyền trước khi lấy Token hoặc cài đặt handler
      await requestPermission();
      await setupMessageHandler();

      // Cấu hình hiển thị foreground mặc định của Firebase cho iOS
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

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
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      print('Permission status: ${settings.authorizationStatus}');
    } catch (e) {
      print('Error requesting permission: $e');
    }
  }

  Future<void> _initLocalNotifications() async {
    try {
      const channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );
      await localNotifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

      // Bật các flag present lên true để iOS nhận diện hiển thị ở Foreground
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const initializationSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await localNotifications.initialize(
        settings: initializationSettings,
        onDidReceiveNotificationResponse: (details) {
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
    navigatorKey.currentState?.pushNamed(
      NotificationScreen.routeName,
      arguments: notificationResponse,
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    try {
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
        id: message.messageId.hashCode,
        title: message.notification?.title ?? 'Notification',
        body: message.notification?.body ?? '',
        notificationDetails: platformDetails,
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
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Received foreground message: ${message.messageId}');
        // Trên iOS, nếu đã set setForegroundNotificationPresentationOptions thì hệ thống tự hiện banner,
        // bạn có thể cân nhắc chỉ cần cập nhật Bloc hoặc call showNotification tuỳ nhu cầu.
        showNotification(message);
      });

      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print('App opened from terminated state: ${initialMessage.messageId}');
        // Thay vì gọi showNotification tạo thêm một cái nữa, ta điều hướng thẳng sang màn hình notify
        navigatorKey.currentState?.pushNamed(
          NotificationScreen.routeName,
          arguments: initialMessage,
        );
      }

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (message.notification != null) {
          print('Background Notification Tapped');
          navigatorKey.currentState?.pushNamed(
            NotificationScreen.routeName,
            arguments: message,
          );
        }
      });
    } catch (e) {
      print('Error setting up message handler: $e');
    }
  }

  // --- Các hàm Topic và Cache (Giữ nguyên logic của bạn nhưng sửa bug logout) ---

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

  Future<Set<String>> _getSubscribedTopics() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('subscribed_topics')?.toSet() ?? {};
  }

  Future<void> _saveSubscribedTopics(Set<String> topics) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('subscribed_topics', topics.toList());
  }

  Future<List<String>?> _getCachedWishList(String studentId) async {
    if (studentId.isEmpty) return [];
    final prefs = await SharedPreferences.getInstance();
    final cachedWishList = prefs.getString('wishlist_$studentId');
    if (cachedWishList != null) {
      return jsonDecode(cachedWishList).cast<String>();
    }
    final wishList = await _studentRepository.fetchWishListByStudentId();
    if (wishList != null) {
      await prefs.setString('wishlist_$studentId', jsonEncode(wishList));
    }
    return wishList;
  }

  Future<void> _saveCachedWishList(String studentId, List<String> wishList) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('wishlist_$studentId', jsonEncode(wishList));
  }

  Future<void> loginStudent(String studentId) async {
    try {
      if (_currentStudentId == studentId) return;

      final subscribedTopics = await _getSubscribedTopics();

      final previousStudentId = _currentStudentId;
      if (previousStudentId != null && previousStudentId != studentId) {
        await unsubscribeFromTopic(previousStudentId);
        subscribedTopics.remove(previousStudentId);
      }

      if (!subscribedTopics.contains(studentId)) {
        await subribeToTopic(studentId);
        subscribedTopics.add(studentId);
      }
      _currentStudentId = studentId;

      final wishList = await _getCachedWishList(studentId);
      if (wishList != null && wishList.isNotEmpty) {
        await Future.wait(
          wishList.where((topic) => !subscribedTopics.contains(topic)).map((topic) async {
            await subribeToTopic(topic);
            subscribedTopics.add(topic);
          }),
        );
      }

      await _saveSubscribedTopics(subscribedTopics);
    } catch (e) {
      print('Error switching student topic: $e');
    }
  }

  Future<void> logoutStudent() async {
    try {
      final studentId = _currentStudentId;
      if (studentId == null) return;

      final subscribedTopics = await _getSubscribedTopics();
      final wishList = await _getCachedWishList(studentId);

      await unsubscribeFromTopic(studentId);
      subscribedTopics.remove(studentId);

      if (wishList != null) {
        await Future.wait(
          wishList.where((topic) => subscribedTopics.contains(topic)).map((topic) async {
            await unsubscribeFromTopic(topic);
            subscribedTopics.remove(topic);
          }),
        );
      }

      await _saveSubscribedTopics(subscribedTopics);
      _currentStudentId = null; // <-- Đưa xuống cuối cùng sau khi đã dùng để clear cache
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  Future<void> followBrand(String brandId) async {
    try {
      final subscribedTopics = await _getSubscribedTopics();
      if (!subscribedTopics.contains(brandId)) {
        await subribeToTopic(brandId);
        subscribedTopics.add(brandId);
        await _saveSubscribedTopics(subscribedTopics);

        final studentId = _currentStudentId ?? (await AuthenLocalDataSource.getStudent())?.id;
        if (studentId != null) {
          final wishList = await _getCachedWishList(studentId) ?? [];
          if (!wishList.contains(brandId)) {
            wishList.add(brandId);
            await _saveCachedWishList(studentId, wishList);
          }
        }
      }
    } catch (e) {
      print('Error following campaign $brandId: $e');
    }
  }

  Future<void> unfollowBrand(String brandId) async {
    try {
      final subscribedTopics = await _getSubscribedTopics();
      if (subscribedTopics.contains(brandId)) {
        await unsubscribeFromTopic(brandId);
        subscribedTopics.remove(brandId);
        await _saveSubscribedTopics(subscribedTopics);

        final studentId = _currentStudentId ?? (await AuthenLocalDataSource.getStudent())?.id;
        if (studentId != null) {
          final wishList = await _getCachedWishList(studentId) ?? [];
          if (wishList.contains(brandId)) {
            wishList.remove(brandId);
            await _saveCachedWishList(studentId, wishList);
          }
        }
      }
    } catch (e) {
      print('Error unfollowing campaign $brandId: $e');
    }
  }
}

final notificationBloc = NotificationBloc();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling background message: ${message.messageId}');
  final notification = message.notification;
  if (notification != null) {
    notificationBloc.add(
      AddNewNotification(
        notificationModel: NotificationModel(
          title: notification.title ?? '',
          body: notification.body ?? '',
          payload: jsonEncode(message.data),
        ),
      ),
    );
  }
}