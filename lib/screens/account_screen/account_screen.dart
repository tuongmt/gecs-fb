import 'package:ecommerce_app/constants/routes.dart';
import 'package:ecommerce_app/provider/app_provider.dart';
import 'package:ecommerce_app/screens/about_us/about_us.dart';
import 'package:ecommerce_app/screens/account_screen/change_password.dart';
import 'package:ecommerce_app/screens/favourite_screen/favourite_screen.dart';
import 'package:ecommerce_app/screens/order_screen/order_screen.dart';
import 'package:ecommerce_app/screens/profile/edit_profile.dart';
import 'package:ecommerce_app/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Account"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              appProvider.getUserInformation.image == null
                  ? const Icon(
                      Icons.person_outline,
                      size: 110,
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(appProvider.getUserInformation.image!),
                    ),
              Text(
                appProvider.getUserInformation.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                appProvider.getUserInformation.email,
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                width: 140,
                child: PrimaryButton(
                  title: "Edit Profile",
                  onPressed: () {
                    Routes.instance
                        .push(widget: const EditProfile(), context: context);
                  },
                ),
              )
            ],
          )),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: const OrderScreen(), context: context);
                    },
                    leading: const Icon(Icons.shopping_bag_outlined),
                    title: const Text("Your Orders"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(
                          widget: const FavouriteScreen(), context: context);
                    },
                    leading: const Icon(Icons.favorite_outline),
                    title: const Text("Favourite"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance
                          .push(widget: const AboutUs(), context: context);
                    },
                    leading: const Icon(Icons.info_outline),
                    title: const Text("About Us"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.support_outlined),
                    title: const Text("Support"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(
                          widget: const ChangePassword(), context: context);
                    },
                    leading: const Icon(Icons.change_circle_outlined),
                    title: const Text("Change Password"),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      setState(() {});
                    },
                    leading: const Icon(Icons.exit_to_app_outlined),
                    title: const Text("Log Out"),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text("Version 1.0.0"),
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
//MTT