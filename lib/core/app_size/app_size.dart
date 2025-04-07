import 'package:flutter/material.dart';

double height(context) {
  return MediaQuery.of(context).size.height;
}

double width(context) {
  return MediaQuery.of(context).size.width;
}
double response(context, double size) {
  double s =
      (height(context) + width(context)) * (size / (750 + 360));
  return s.floorToDouble();
}
