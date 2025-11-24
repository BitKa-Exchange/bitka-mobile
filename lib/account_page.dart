import 'package:flutter/material.dart';
import 'main.dart'; // For colors

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The new design implies a back button, so we use an AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // In a real app, you might pop, but since this is a main tab,
            // we'll just stay here or you could navigate to home.
            // Navigator.pop(context);
            // For now, let's just print a message
            print('Back button pressed');
          },
        ),
        title: const Text(
          'Account',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Profile Header
              _buildProfileHeader(),
              const SizedBox(height: 30),
              // Menu Options
              _buildMenuItem(
                Icons.person_outline,
                'Verification',
                trailingText: 'Level 1',
              ),
              _buildMenuItem(Icons.shield_outlined, 'Security'),
              _buildMenuItem(Icons.percent, 'Fee Levels'),
              _buildMenuItem(Icons.account_balance, 'Bank Account'),
              _buildMenuItem(Icons.book_outlined, 'Address Management'),
              _buildMenuItem(Icons.settings_outlined, 'Settings'),
              _buildMenuItem(Icons.headset_mic_outlined, 'Support'),
              _buildMenuItem(Icons.info_outline, 'About'),

              const SizedBox(height: 30),
              // Logout
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to login and clear stack
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Log out',
                    style: TextStyle(color: Colors.redAccent, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'v.3.20.0',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        // Avatar
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: primaryPink,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'N',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Name and Email
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Nattan Niparnee',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'nattan.niparnee@gmail.com',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {String? trailingText}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white12, width: 1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          if (trailingText != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                trailingText,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}
