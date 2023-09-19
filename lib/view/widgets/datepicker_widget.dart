import 'package:attendance/constant/strings.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final IconData iconName;
  final String hintText;
  final TextEditingController? textController;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  const DatePickerWidget(
      {super.key,
      required this.textController,
      required this.onTap,
      required this.hintText,
      required this.iconName,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        validator: validator,
        enabled: false,
        readOnly: true,
        controller: textController,
        decoration: Styles.textInputBlue.copyWith(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Strings.ColorBlue, width: 2)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Strings.ColorBlue, width: 2)),
          hintText: hintText,
          prefixIcon: Icon(
            iconName,
            color: Strings.ColorBlue,
          ),
        ),
      ),
    );
  }
}
