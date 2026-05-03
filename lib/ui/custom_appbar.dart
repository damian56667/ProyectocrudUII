import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLogout;
  final VoidCallback? onLogout;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showLogout = false,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF000000),
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.playfairDisplay(
          color: const Color(0xFFD4AF37),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFFD4AF37)),
      actions: [
        if (showLogout)
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFFD4AF37)),
            onPressed: onLogout,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
