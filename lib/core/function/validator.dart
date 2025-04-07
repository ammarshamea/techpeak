import 'package:flutter/material.dart';

String? validateEmail(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return "يرجى إدخال الايميل الخاص بك.";
  }

  return null;
}

String? validatePassword(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return "يرجى إدخال كلمة المرور.";
  }
  if (value.length < 8) {
    return "يجب أن تتكون كلمة المرور من 8 أحرف على الأقل.";
  }
  return null;
}

String? validateNotHaveValue(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return "هذا الحقل مطلوب.";
  }
  return null;
}
