import 'package:flutter/widgets.dart';

Widget addHorizontalSpace ({double space = 20}) {
  return SizedBox(
    height: space,
  );
}

Widget addVerticalSpace ({double space = 20}) {
  return SizedBox(
    width: space,
  );
}