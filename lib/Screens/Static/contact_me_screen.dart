import 'package:flutter/material.dart';
import 'package:qr_code_generator/Widgets/CommonWIdgets.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/FFontStyles.dart';

class ContactMeScreen extends StatefulWidget {
  const ContactMeScreen({super.key});

  @override
  _ContactMeScreenState createState() => _ContactMeScreenState();
}

class _ContactMeScreenState extends State<ContactMeScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize AnimationController
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
      backgroundColor: Colors.white, // Soft Gray background
      appBar: AppBar(
        backgroundColor: AppColors.brandNew,
        title: Text(
          'Contact Me',
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
                    'Get in Touch',
                      style: CustomTextStyles.subheading(context)
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'Have questions or feedback? Reach out to us through the following channels:',
                      style: CustomTextStyles.body(context),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: height * 0.03),
                  // In _buildContactTile calls, update the onTap callbacks
                  _buildContactTile(
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: 'bhoopendrablog@gmail.com',
                      onTap: () => URLLauncherUtils.launch(context, 'mailto:bhoopendrablog@gmail.com')
                  ),
                  _buildContactTile(
                    icon: Icons.language,
                    title: 'Website',
                    subtitle: 'Click to view',
                    onTap: () => URLLauncherUtils.launch(context, 'https://trozenwho.blogspot.com/'),
                  ),
                  _buildContactTile(
                    icon: Icons.video_library,
                    title: 'YouTube',
                    subtitle: '@trozen04',
                    onTap: () => URLLauncherUtils.launch(context, 'https://www.youtube.com/@trozen04'),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.brandNew),
      title: Text(title, style: CustomTextStyles.body(context)),
      subtitle: Text(subtitle),
      onTap: onTap,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}