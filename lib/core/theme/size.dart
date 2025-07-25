

import 'package:flutter/widgets.dart';

class AppSize {

  static double height=0;
  static double width=0;

  AppSize._();

  static void screenSize(BuildContext context)
  {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
  }
   
   
 static double buttonHeight(double percent) => height * percent;
 static double iconSize(double scale) => width*scale;
 static double textSize(double scale) => width*scale;
 static double buttonWidth(double percent) => width*percent;
 static double horizontalPadding(double percent) => width*percent;
 static double verticalPadding(double percent) => height*percent;
}