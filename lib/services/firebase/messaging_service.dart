import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../../core/types/result.dart';
import '../../core/config/supabase_config.dart';

class MessagingService {
  final FirebaseMessaging _messaging;
  final _notificationStreamController = StreamController<RemoteMessage>.broadcast();

  MessagingService({FirebaseMessaging? messaging})
      : _messaging = messaging ?? FirebaseMessaging.instance;

  Stream<RemoteMessage> get notificationStream => _notificationStreamController.stream;

  Future<Result<void>> initialize() async {
    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        final token = await _messaging.getToken();
        if (token != null) {
          await _storeToken(token);
        }

        // Handle token refresh
        _messaging.onTokenRefresh.listen(_storeToken);

        // Handle foreground messages
        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

        // Handle background messages
        FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

        // Handle message open
        FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

        return const Success(null);
      } else {
        return Failure(message: 'Notification permissions were denied');
      }
    } catch (e) {
      return Failure(message: 'Failed to initialize messaging service', error: e);
    }
  }

  Future<void> _storeToken(String token) async {
    try {
      await SupabaseConfig.client
          .from('device_tokens')
          .upsert({'token': token}, onConflict: 'token');
    } catch (e) {
      debugPrint('Failed to store FCM token: $e');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    _notificationStreamController.add(message);
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    _notificationStreamController.add(message);
  }
}

@pragma('vm:entry-point')
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  // Handle background message
  // Note: This function must be top-level and can't access instance members
  debugPrint('Handling background message: ${message.messageId}');
}
