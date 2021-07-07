import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:noon_reader/services/setting.dart';
import 'package:noon_reader/widgets/noon_app_bar.dart';

class ViewerPage extends HookWidget {
  final String content;

  ViewerPage({required this.content});

  @override
  Widget build(BuildContext context) {
    final setting = useProvider(settingServiceProvider).setting;

    return Scaffold(
      appBar: NoonAppBar(),
      body: Container(
        height: double.infinity,
        color: setting.backgroundColor,
        child: SingleChildScrollView(
          padding: setting.padding,
          child: Text(
            content,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
