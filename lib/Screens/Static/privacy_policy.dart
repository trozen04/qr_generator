import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/FFontStyles.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Define fade animation (opacity from 0 to 1)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Define slide animation (from 20 pixels below to original position)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Slide from 20% below
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Start the animation
    _controller.forward();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.brandNew,
        title: Text(
          'Privacy Policy',
          style: CustomTextStyles.heading(context).copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.035),
        child: SingleChildScrollView(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📄 Privacy Policy – QRevix',
                    style: CustomTextStyles.subheading(context),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'QRevix is a free QR code generator app developed by Trozen. We provide this app at no cost and it is intended for use as-is. '
                        'This Privacy Policy explains what data we collect (if any), how we use it, and your rights as a user. By using QRevix, you agree to the terms outlined in this policy.',
                    style: CustomTextStyles.body(context),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    '🔐 Information Collection and Use',
                    style: CustomTextStyles.subheading(context),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'QRevix does not collect, use, or store any personal information. '
                        'All QR codes are generated locally on your device, and no data is transmitted to any server.',
                    style: CustomTextStyles.body(context),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    '📲 Permissions',
                    style: CustomTextStyles.subheading(context),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'QRevix does not request any special permissions from your device. No camera, storage, or location access is required to use the app.',
                    style: CustomTextStyles.body(context),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    '🔗 Third-Party Services',
                    style: CustomTextStyles.subheading(context),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'QRevix does not integrate or rely on any third-party services that collect user data.',
                    style: CustomTextStyles.body(context),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    '📬 Contact Us',
                    style: CustomTextStyles.subheading(context),
                  ),
                  SizedBox(height: height * 0.01),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: CustomTextStyles.body(context),
                      children: [
                        const TextSpan(
                          text:
                          'If you have any questions or suggestions about this Privacy Policy, feel free to contact us at: ',
                        ),
                        TextSpan(
                          text: 'bhoopendrablog@gmail.com',
                          style: CustomTextStyles.body(context).copyWith(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrl(
                                Uri.parse('mailto:bhoopendrablog@gmail.com'),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomInfoRow({
    required BuildContext context,
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: CustomTextStyles.body(context),
        ),
        Text(
          value,
          style: CustomTextStyles.body(context).copyWith(color: AppColors.greyText),
        ),
      ],
    );
  }
}