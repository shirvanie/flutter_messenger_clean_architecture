

import 'package:flutter/material.dart';

class ScreenSize {

  const ScreenSize();

  static double fullWidthScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double fullHeightScreen(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double setScreenWidth(BuildContext context, double width) => /// width must between 0 and 1
      fullWidthScreen(context) * width;

  static double setScreenHeight(BuildContext context, double height) =>/// height must between 0 and 1
      fullHeightScreen(context) * height;

}
