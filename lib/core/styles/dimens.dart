import 'package:flutter/cupertino.dart';

class Dimens{
  BuildContext context;
  Dimens(this.context);

  static double heighMax(context) => MediaQuery.of(context).size.height;
  static double widthMax(context) => MediaQuery.of(context).size.width;

  static heighBottomKeyboard(context) => MediaQuery.of(context).viewInsets.bottom*0.35;

  static const double clipRounded = 30.0;
  static const double defaultMargin = 20.0;
}