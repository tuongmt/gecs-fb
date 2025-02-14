import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(
      builder: (context) {
        return SizedBox(
          width: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: Colors.blue,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 18.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Loading..."),
              )
            ],
          ),
        );
      },
    ),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

String getMessageFromErrorCode(String errCode) {
  switch (errCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email already used!";
    case "ERROR_WRONG_PASSWORD":
      return "Password is wrong!";
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email!";
    case "ERROR_USER_DISABLED":
      return "User disabled!";
    case "ERROR_INVALID_EMAIL":
      return "Email address is invalid!";
    default:
      return "Login failed. Please try again.";
  }
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Both fields are empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is empty");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("All fields are empty");
    return false;
  } else if (name.isEmpty) {
    showMessage("Name is empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is empty");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Phone is empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is empty");
    return false;
  } else {
    return true;
  }
}

