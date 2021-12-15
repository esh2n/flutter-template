import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '00_common/provider/firebase_analytics_provider.dart';
import '00_common/provider/firebase_messaging_provider.dart';
import '00_common/provider/flavor_provider.dart';
import '00_common/provider/package_info_provider.dart';
import '01_presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const flavor = String.fromEnvironment('FLAVOR');
  late final PackageInfo pi;
  late final FirebaseMessagingHelper fcmHelper;
  await Future.wait([
    Future(Firebase.initializeApp),
  ]);
  await Future.wait([
    Future(() async => await Hive.initFlutter()),
    Future(() async => pi = await PackageInfo.fromPlatform()),
    Future(() async => fcmHelper = FirebaseMessagingHelper(FCMConfig.instance)),
    Future(() async => FirebaseAnalyticsHelper()),
  ]);
  runApp(
    ProviderScope(
      overrides: [
        flavorProvider.overrideWithValue(FlavorFromString.call(flavor)),
        packageInfoProvider.overrideWithValue(pi),
      ],
      child: FCMNotificationListener(
        onNotification: fcmHelper.onNotification,
        child: const App(),
      ),
    ),
  );
}
