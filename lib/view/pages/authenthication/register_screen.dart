import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/guest_ctrl.dart';
import 'package:attendance/view/pages/authenthication/login.dart';
import 'package:attendance/view/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Strings.bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formGlobalKey,
              child: GetBuilder<GuestGetx>(
                  init: GuestGetx(),
                  builder: (controller) {
                    return Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back_ios)),
                            ]),
                        SizedBox(height: 5.0),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Image.asset("assets/image/tp_logo.png")),
                        SizedBox(height: 30.0),
                        Text(
                          Strings.welcome,
                          style: Styles.latoWelcomeStyle,
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Register As Guest',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Strings.bgColor_2,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 45.0, right: 45.0),
                          child: DropdownButtonFormField(
                            value: controller.selectedOption,
                            items: controller.options.map((String option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              controller.selectedOption = newValue! as String?;
                              log(controller.selectedOption.toString());
                            },
                            decoration: InputDecoration(
                              labelText: 'Choose An Organization',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        WidgetTextFormField(
                          ctrl: controller.name,
                          hinttext: 'Name',
                          validator: (value) =>
                              controller.nameValidation(value),
                        ),
                        WidgetTextFormField(
                          ctrl: controller.email,
                          hinttext: 'Email',
                          validator: (value) =>
                              controller.emailValdation(value),
                        ),
                        WidgetTextFormField(
                          ctrl: controller.phone,
                          hinttext: 'Phone',
                          validator: (value) =>
                              controller.phoneValidation(value),
                          keyboardtype: TextInputType.phone,
                        ),
                        WidgetTextFormField(
                          obscure: true,
                          ctrl: controller.password,
                          hinttext: 'Password',
                          maxLines: false,
                          validator: (value) =>
                              controller.passwordValidation(value),
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: Strings.primaryColor,
                            minimumSize: const Size(210, 55),
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            if (formGlobalKey.currentState!.validate()) {
                              formGlobalKey.currentState!.save();
                              await controller.signupGuest(
                                  controller.name.text,
                                  controller.email.text,
                                  controller.phone.text,
                                  controller.password.text);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                  (route) => false);
                              print(
                                  '${controller.name.text}\n${controller.email.text}\n${controller.phone.text}\n${controller.password.text}');
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
