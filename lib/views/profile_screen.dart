import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_application/utilis/colors/color_constant.dart';
import 'package:split_application/utilis/text/text_constant.dart';
import 'package:split_application/views/authentication/login_screen.dart';
import 'package:split_application/views/bottom_nav_bar_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildUserHeader(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              _buildProfileSection(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildUserHeader() {
  return Column(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(
          'https://img.freepik.com/premium-vector/character-avatar-isolated_729149-194801.jpg?semt=ais_hybrid',
        ),
      ),
      const SizedBox(height: 16),
      Text("John Doe", style: AppTextStyles.headingStyle.copyWith()),
      const SizedBox(height: 8),
      Text("john.doe@gmail.com",
          style: AppTextStyles.bodyStyle.copyWith(
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w600,
          )),
    ],
  );
}

Widget _buildProfileSection(BuildContext context) {
  return Column(
    children: [
      _buildProfileMenuItem(
        icon: Icons.edit,
        title: "Edit Profile",
        onTap: () {
          // TODO: Navigate to Edit Profile Screen
        },
      ),
      const Divider(),
      _buildProfileMenuItem(
        icon: Icons.lock,
        title: "Security",
        onTap: () {
          // TODO: Navigate to Security Screen
        },
      ),
      const Divider(),
      _buildProfileMenuItem(
        icon: Icons.support_agent,
        title: "Customer Support",
        onTap: () {
          // TODO: Navigate to Customer Support Screen
        },
      ),
      const Divider(),
      _buildProfileMenuItem(
        icon: Icons.help_outline,
        title: "FAQ",
        onTap: () {
          // TODO: Navigate to FAQ Screen
        },
      ),
      const Divider(),
      _buildProfileMenuItem(
        icon: Icons.share,
        title: "Share App",
        onTap: () {
          // TODO: Implement share functionality
        },
      ),
      const Divider(),
      _buildProfileMenuItem(
        icon: Icons.logout,
        title: "Logout",
        onTap: () {
          navigationAction(context);
        },
        isLogout: true,
      ),
    ],
  );
}

Widget _buildProfileMenuItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  bool isLogout = false,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: isLogout ? Colors.red : null,
    ),
    title: Text(
      title,
      style: isLogout
          ? AppTextStyles.subHeadingStyle.copyWith(color: Colors.red)
          : AppTextStyles.subHeadingStyle,
    ),
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap,
  );
}

void navigationAction(context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}
