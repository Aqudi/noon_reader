import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:noon_reader/widgets/noon_app_bar.dart';
import 'package:noon_reader/widgets/viewer_container.dart';

class ViewerPage extends HookWidget {
  final String content;

  const ViewerPage({required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NoonAppBar(),
      body: ViewerContainer(content),
    );
  }
}
