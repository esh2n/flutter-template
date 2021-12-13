import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flavorProvider = Provider<Flavor>((ref) => throw UnimplementedError());

enum Flavor {
  dev,
  stg,
  prod,
}

extension FlavorFromString on Flavor {
  String get value => describeEnum(this);

  static Flavor call(String str) {
    if (Flavor.dev.value == str) {
      return Flavor.dev;
    } else if (Flavor.stg.value == str) {
      return Flavor.stg;
    } else if (Flavor.prod.value == str) {
      return Flavor.prod;
    } else {
      throw AssertionError('Invalid flavor.');
    }
  }
}
