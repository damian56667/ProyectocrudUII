import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ui/custom_appbar.dart';
import '../ui/luxury_buttons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Panel Principal',
        showLogout: true,
        onLogout: () async {
          await FirebaseAuth.instance.signOut();
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inventory_2,
              size: 120,
              color: Color(0xFF000000),
            ),
            const SizedBox(height: 40),
            LuxuryButton(
              text: 'PERFUMES',
              onPressed: () {
                Navigator.pushNamed(context, '/crud');
              },
            ),
          ],
        ),
      ),
    );
  }
}
