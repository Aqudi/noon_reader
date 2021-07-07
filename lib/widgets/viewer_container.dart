import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:noon_reader/services/setting.dart';

class ViewerContainer extends HookWidget {
  final String content;

  const ViewerContainer(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final setting = useProvider(settingServiceProvider).setting;

    return Container(
      height: double.infinity,
      color: setting.backgroundColor,
      child: SingleChildScrollView(
        padding: setting.padding,
        child: Text(
          content,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
