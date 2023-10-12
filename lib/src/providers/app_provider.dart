import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int selectedNavigatorIndex = 0;

  changeIndex(int index) {
    selectedNavigatorIndex = index;
    print("index changed to $index");
    notifyListeners();
  }

  bool isDarkMood = false;

  updateAppearance(bool isDark) {
    isDarkMood = isDark;
    notifyListeners();
  }

  Color get scafoldBackground {
    if (isDarkMood) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color get background {
    if (isDarkMood) {
      return Color.fromARGB(255, 35, 34, 43);
    } else {
      return Color.fromARGB(255, 223, 223, 223);
    }
  }

  Color get TextColor {
    if (isDarkMood) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color get TextColor1 {
    if (isDarkMood) {
      return Color.fromARGB(255, 173, 173, 173);
    } else {
      return Color.fromARGB(255, 78, 78, 78);
    }
  }
}
