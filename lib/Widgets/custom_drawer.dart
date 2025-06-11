import 'package:flutter/material.dart';
import 'package:qr_code_generator/Screens/Static/privacy_policy.dart';
import 'package:qr_code_generator/Utils/ImageAssets.dart';
import '../Screens/Static/about_screen.dart';
import '../Screens/Static/contact_me_screen.dart';
import 'CommonWIdgets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            child: Image.asset(ImageAssets.appIconHome)
          ),
          CustomListTile(
            icon: Icons.info_rounded,
            title: 'About',
            onTap: () {
              Navigator.of(context).push(
                NavigationUtils.slideTransition(AboutScreen()),
              );
            },
          ),
          CustomListTile(
            icon: Icons.contact_mail,
            title: 'Contact Me',
            onTap: () {
              Navigator.of(context).push(
                NavigationUtils.slideTransition(ContactMeScreen()),
              );
            },
          ),
          CustomListTile(
            icon: Icons.local_police_outlined,
            title: 'Privacy Policy',
            onTap: () {
              Navigator.of(context).push(
                NavigationUtils.slideTransition(PrivacyPolicy()),
              );
            },
          ),
        ],
      ),
    );
  }
}

