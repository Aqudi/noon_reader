import 'package:flutter/material.dart';
import 'package:noon_reader/constants/app.dart';

class NoonAppBar extends StatelessWidget with PreferredSizeWidget {
  const NoonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppConstants.appName),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
