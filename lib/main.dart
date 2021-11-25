import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '00_common/provider/flavor_provider.dart';
import '00_common/provider/package_info_provider.dart';
import '01_presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const flavor = String.fromEnvironment('FLAVOR');
  late final PackageInfo pi;
  await Future.wait([
    Future(Firebase.initializeApp),
    Future(() async => await Hive.initFlutter()),
    Future(() async => pi = await PackageInfo.fromPlatform()),
  ]);
  runApp(
    ProviderScope(
      overrides: [
        flavorProvider.overrideWithValue(FlavorFromString.call(flavor)),
        packageInfoProvider.overrideWithValue(pi),
      ],
      child: const App(),
    ),
  );
}
