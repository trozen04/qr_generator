import 'package:flutter/material.dart';
import 'package:qr_code_generator/Utils/AppColors.dart';
import 'package:qr_code_generator/Utils/FFontStyles.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.brandNew, size: 20),
          title: Text(title, style: CustomTextStyles.body(context)),
          onTap: onTap,
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: AppColors.textfieldborder, // Or use a theme color if preferred
        ),
      ],
    );
  }
}

class NavigationUtils {
  static Route slideTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide from right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

