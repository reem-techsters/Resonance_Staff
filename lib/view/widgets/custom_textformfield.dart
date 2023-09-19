import 'package:flutter/material.dart';

class WidgetTextFormField extends StatelessWidget {
  final TextEditingController ctrl;
  final String hinttext;
  final bool? obscure;
  final bool? maxLines;
  final int? hardcodemaxLines;
  final TextInputType? keyboardtype;
  final AutovalidateMode? onUserInteraction;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final String? Function(String?)? validator;
  final double? leftandrightpadding;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  const WidgetTextFormField(
      {super.key,
      required this.ctrl,
      required this.hinttext,
      this.obscure,
      this.validator,
      this.onUserInteraction,
      this.keyboardtype,
      this.borderRadius,
      this.borderSide,
      this.leftandrightpadding,
      this.textStyle,
      this.maxLines,
      this.focusNode,
      this.hardcodemaxLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 20.0,
          left: leftandrightpadding ?? 40.0,
          right: leftandrightpadding ?? 40.0),
      child: TextFormField(
        focusNode: focusNode,
        maxLines: hardcodemaxLines ??
            (maxLines == true ? (hinttext.length / 18).ceil() : 1),
        keyboardType: keyboardtype ?? TextInputType.text,
        autovalidateMode: onUserInteraction ?? AutovalidateMode.disabled,
        textAlign: TextAlign.left,
        validator: validator,
        obscureText: obscure ?? false,
        style: textStyle ??
            TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
        controller: ctrl,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hinttext,
          contentPadding: EdgeInsets.all(20.0),
          disabledBorder: OutlineInputBorder(
            borderSide: borderSide ?? BorderSide.none,
            borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(40)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: borderSide ?? BorderSide.none,
            borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(40)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: borderSide ?? BorderSide.none,
            borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(40)),
          ),
          border: OutlineInputBorder(
              borderRadius:
                  borderRadius ?? BorderRadius.all(Radius.circular(40))),
        ),
      ),
    );
  }
}
