import 'dart:developer';

import 'package:flutter/material.dart';

import '../../constant/strings.dart';

class CustomTextField {
  static Widget textField(TextEditingController ctrl, String hint,
      {enabled, validator, submitHint}) {
    // print("lengthHint ${(hint.length).round()}");
    print("lengthHint ${(hint.length / 18).ceil()}");
    // print("lengthHint ${(hint.length / 18)}");
    return TextFormField(
        enabled: enabled,
        validator: (value) => validator,
        keyboardType: TextInputType.multiline,
        controller: ctrl,
        maxLines: submitHint ?? (hint.length / 18).ceil(),
        // maxLines: 1,
        decoration: Styles.textInputBlue.copyWith(
          hintText: hint,
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 2)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Strings.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.shade600,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 0),
        ));
  }

  static Widget dialogDescTextField(TextEditingController ctrl) {
    return TextField(
        keyboardType: TextInputType.multiline,
        controller: ctrl,
        maxLines: 10,
        decoration: Styles.textInputBlue.copyWith(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Strings.primaryColor, width: 2)),
          hintText: "  Enter Reason",
          // hintStyle: TextStyle(color: Colors.black),
          contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 0),
        )
        // contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
        );
  }
}
