import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SectionTitle(number: '1.', title: 'Information We Collect'),
            _SectionText(
              text:
                  'We collect information you provide directly to us, such as '
                  'when you create or modify your account, request on-demand '
                  'services, contact customer support, or otherwise communicate with us.',
            ),

            SizedBox(height: 24),

            _SectionTitle(number: '2.', title: 'How We Use Your Information'),
            _SectionText(
              text:
                  'We use the information we collect to provide, maintain, and '
                  'improve our services, such as to facilitate payments, send '
                  'receipts, provide products and services you request (and send '
                  'related information), develop new features, provide customer '
                  'support to Users and Drivers, develop safety features, '
                  'authenticate users, and send product updates and administrative messages.',
            ),

            SizedBox(height: 24),

            _SectionTitle(number: '3.', title: 'Sharing of Information'),
            _SectionText(
              text:
                  'We may share the information we collect about you as described '
                  'in this Statement or as described at the time of collection or sharing, '
                  'including as follows:',
            ),

            SizedBox(height: 12),

            _BulletPoint(
              text:
                  'With third party service providers to facilitate our services;',
            ),
            _BulletPoint(
              text:
                  'With third parties with whom you choose to let us share information, '
                  'for example other apps or websites that integrate with our API or Services;',
            ),
            _BulletPoint(
              text:
                  'With law enforcement officials, government authorities, or other '
                  'third parties if we believe your actions are inconsistent with our '
                  'User agreements, Terms of Service, or policies, or to protect the rights, '
                  'property, or safety of ShopApp or others.',
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String number;
  final String title;

  const _SectionTitle({required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$number $title',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xffE20075),
      ),
    );
  }
}

class _SectionText extends StatelessWidget {
  final String text;

  const _SectionText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          height: 1.6,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}
