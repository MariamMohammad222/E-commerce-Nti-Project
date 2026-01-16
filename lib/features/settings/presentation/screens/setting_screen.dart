import 'package:final_project/Screens/about_us_screen.dart';
import 'package:final_project/Screens/contact_us_screen.dart';
import 'package:final_project/Screens/privacy_policy_screen.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
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
                    const Text('Dark Mode', style: TextStyle(fontSize: 16)),
                    const Spacer(),
                    Switch(
                      value: isDarkMode,
                      activeColor: Color(0xffF13B96),
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = value;
                        });
                      },
                    ),
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
                  onPressed: () {},
                ),
              ),
            ],
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
