
// import 'package:HackathonApp/conStants/colors.dart';
// import 'package:flutter/material.dart';

import 'package:HackathonApp/conStants/colors.dart';
import 'package:flutter/material.dart';

class ThemeChange{
  static void toggleTheme() {



    if (AppColors.blacktextcolor == Colors.black) {
      AppColors.whitetextcolor= Colors.black;
      AppColors.blacktextcolor = Colors.white;
    } else {
      AppColors.whitetextcolor= Colors.white;
      AppColors.blacktextcolor = Colors.black;
    }
  }
}