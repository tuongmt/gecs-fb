import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ecommerce_app/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isHidePassword = true;
  //TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Change Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            // TextFormField(
            //   controller: oldPassword,
            //   obscureText: isHidePassword,
            //   decoration: InputDecoration(
            //     hintText: "Old Password",
            //     prefixIcon: const Icon(
            //       Icons.lock_outline,
            //     ),
            //     suffixIcon: CupertinoButton(
            //         onPressed: () {
            //           setState(() {
            //             isHidePassword = !isHidePassword;
            //           });
            //         },
            //         padding: EdgeInsets.zero,
            //         child: const Icon(Icons.visibility)),
            //   ),
            // ),
            TextFormField(
              controller: newPassword,
              obscureText: isHidePassword,
              decoration: InputDecoration(
                hintText: "New Password",
                prefixIcon: const Icon(
                  Icons.lock_outline,
                ),
                suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isHidePassword = !isHidePassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Icon(
                      isHidePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: confirmPassword,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: Icon(
                  Icons.lock_outline,
                ),
              ),
            ),
            const SizedBox(
              height: 36.0,
            ),
            PrimaryButton(
              title: "Update",
              onPressed: () async {
                if (newPassword.text.isEmpty) {
                  showMessage("New Password is not allowed  empty ");
                } else if (confirmPassword.text.isEmpty) {
                  showMessage("Confirm Password is not allowed  empty ");
                } else if (newPassword.text != confirmPassword.text) {
                  showMessage("Confirm Password is not match ");
                } else {
                  FirebaseAuthHelper.instance
                      .changePassword(newPassword.text, context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
