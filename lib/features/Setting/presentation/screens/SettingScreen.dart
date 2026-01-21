
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_project_final/core/theme/appThemeCubit.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/Setting/presentation/screens/aboutUsScreen.dart';
import 'package:nti_project_final/features/Setting/presentation/screens/contact-usScreen.dart';
import 'package:nti_project_final/features/Setting/presentation/screens/privacyPolicyScreen.dart';

import 'package:flutter/material.dart';
import 'package:nti_project_final/features/auth/presentation/screens/LoginScreen.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ================= Profile Photo =================
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/Image.png'),
                  ),
                ),
            
                SizedBox(height: 10),
            
                Text(
                  'Ikmk',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
            
                SizedBox(height: 4),
            
                Text('Imkjo@klin', style: TextStyle(color: Colors.grey)),
            
                SizedBox(height: 30),
            
                // =============== Dark Mode =======================
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 69,
                  decoration: BoxDecoration(
                    color: const Color(0xffFBE0EE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.dark_mode_outlined,
                        color: Color(0xffF13B96),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Dark Mode',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const Spacer(),
               BlocBuilder<AppThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return Switch(
                  value: themeMode == ThemeMode.dark,
                  activeThumbColor: const Color(0xffF13B96),
                  onChanged: (value) {
                    context.read<AppThemeCubit>().changeAppTheme(
                value ? ThemeMode.dark : ThemeMode.light,
              );
                  },
                );
              },
            )
            
                       
                    ],
                  ),
                ),
                SizedBox(height: 28),
            
                // ======================================
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffFBE0EE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _settingsItem(
                        Icons.shopping_bag_outlined,
                        'My Orders',
                        () {},
                      ),
                      _settingsItem(
                        Icons.credit_card_outlined,
                        'Payment Methods',
                        () {},
                      ),
                      _settingsItem(Icons.shield_outlined, 'Privacy Policy', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyScreen(),
                          ),
                        );
                      }),
                      _settingsItem(Icons.info_outline, 'About Us', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutUsScreen(),
                          ),
                        );
                      }),
                      _settingsItem(Icons.mail_outline, 'Contact Us', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactUsScreen(),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 28),
                // ==================Log out====================
                SizedBox(
                  width: double.infinity,
                  height: 69,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFBE0EE),
                      foregroundColor: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.logout),
                    label: const Text(
                      'Log Out',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Log out'),
                          content: const Text(
                            'Are you sure you want to log out?',
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child:  Text(
                                'Log out',
                                style: TextStyle(color: AppColor.primaryColor),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _settingsItem(IconData icon, String title, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: Colors.black),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: onTap,
  );
}