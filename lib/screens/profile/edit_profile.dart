import 'dart:io';
import 'package:ecommerce_app/models/user_model/user_model.dart';
import 'package:ecommerce_app/provider/app_provider.dart';
import 'package:ecommerce_app/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController tecName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            image == null
                ? CupertinoButton(
                    onPressed: () {
                      takePicture();
                    },
                    child: const CircleAvatar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        radius: 50,
                        child: Icon(Icons.camera_alt_outlined)),
                  )
                : CupertinoButton(
                    onPressed: () {
                      takePicture();
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(image!),
                    ),
                  ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: tecName,
              decoration: InputDecoration(
                  hintText: appProvider.getUserInformation.name),
            ),
            const SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              title: "Update",
              onPressed: () async {
                UserModel userModel =
                    appProvider.getUserInformation.copyWith(name: tecName.text);
                appProvider.updateUserInfoFirebase(context, userModel, image);
              },
            )
          ],
        ),
      ),
    );
  }
}
