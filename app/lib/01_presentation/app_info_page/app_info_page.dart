import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:routemaster/routemaster.dart';
import '../../00_common/provider/package_info_provider.dart';
import '../../00_common/provider/flavor_provider.dart';

class AppInfoPage extends ConsumerWidget {
  const AppInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final flavor = ref.watch(flavorProvider);
    final packageInfo = ref.watch(packageInfoProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(Routemaster.of(context).currentRoute.fullPath),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Text('App Info', style: textTheme.headline2)),
              const Gap(16),
              Text('Flavor', style: textTheme.headline3),
              Text(flavor.value),
              const Gap(32),
              Text('App name', style: textTheme.headline4),
              Text(packageInfo.appName),
              const Gap(32),
              Text('Package name', style: textTheme.headline4),
              Text(packageInfo.packageName),
              const Divider(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
