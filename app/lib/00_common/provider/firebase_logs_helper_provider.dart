import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;

final firebaseLogsHelperProvider =
    Provider<FirebaseLogsHelper>((ref) => FirebaseLogsHelper());

class FirebaseLogsHelper {
  FirebaseLogsHelper() {
    _analytics = FirebaseAnalytics();
    observer = FirebaseAnalyticsObserver(analytics: _analytics!);
    Future.wait([
      Future(() async => await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(true)),
      Future(() async => await _analytics?.setAnalyticsCollectionEnabled(true)),
      Future(() async => await appOpen()),
      Future(() async =>
          FlutterError.onError = (FlutterErrorDetails details) async {
            await FirebaseCrashlytics.instance.recordFlutterError(details);
            if (kDebugMode) {
              FlutterError.dumpErrorToConsole(details);
            } else {
              Zone.current
                  .handleUncaughtError(details.exception, details.stack!);
            }
          }),
    ]);
    // FirebaseCrashlytics.instance.crash();
  }

  late final FirebaseAnalytics? _analytics;
  late final FirebaseAnalyticsObserver? observer;

  Future<void> appOpen() async {
    try {
      await _analytics?.logAppOpen();
    } catch (e) {
      developer.log('Error on oppOpen(): $e');
      rethrow;
    }
  }

  Future<void> sendEvent(
    String name,
    Map<String, dynamic> map,
  ) async {
    try {
      await _analytics?.logEvent(
        name: name,
        parameters: map,
      );
    } catch (e) {
      developer.log('Error on sendEvent(): $e');
      rethrow;
    }
  }
}
