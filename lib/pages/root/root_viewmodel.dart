import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rootViewModelProvider = ChangeNotifierProvider((ref) => RootViewModel());

class RootViewModel with ChangeNotifier {
  int selectedIndex = 0;

  void setSelectedIndex(int _selectedIndex) {
    selectedIndex = _selectedIndex;
    notifyListeners();
  }
}
