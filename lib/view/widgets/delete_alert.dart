import 'dart:developer';
import 'package:attendance/controller/model_state/guest_ctrl.dart';
import 'package:attendance/view/pages/authenthication/login.dart';
import 'package:attendance/view/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDeleteAlert extends StatelessWidget {
  final String roleid;
  const UserDeleteAlert({Key? key, required this.roleid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuestGetx>(
        init: GuestGetx(),
        builder: (controller) {
          return AlertDialog(
            content: Text(
              'Do you want to delete this account?',
              style: TextStyle(
                color: Color.fromARGB(255, 78, 77, 77),
                letterSpacing: 0.1,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  children: [
                    Buttons.redButtonReason('Delete', () async {
                      await controller.userAccountDelete(roleid);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                          (route) => false);

                      log('Delete Account In Progress');
                    }),
                    Spacer(),
                    Buttons.blueButtonReason("Cancel", () {
                      Navigator.pop(context);
                    })
                  ],
                ),
              )
            ],
          );
        });
  }
}

class GuestDeleteAlert extends StatelessWidget {
  final String roleid;
  const GuestDeleteAlert({Key? key, required this.roleid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuestGetx>(
        init: GuestGetx(),
        builder: (controller) {
          return AlertDialog(
            content: Text(
              'Do you want to delete this account?',
              style: TextStyle(
                color: Color.fromARGB(255, 78, 77, 77),
                letterSpacing: 0.1,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  children: [
                    Buttons.redButtonReason('Delete', () async {
                      await controller.guestAccountDelete(roleid);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                          (route) => false);
                    }),
                    Spacer(),
                    Buttons.blueButtonReason("Cancel", () {
                      Navigator.pop(context);
                    })
                  ],
                ),
              )
            ],
          );
        });
  }
}
