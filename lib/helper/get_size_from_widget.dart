import 'package:flutter/material.dart';

Size? getWidgetSize(BuildContext? context) { // context here can be obtained from key.currentContext
  if (context != null){
    final box = context.findRenderObject() as RenderBox;
    return box.size;
  } else {
    return null;
  }
}