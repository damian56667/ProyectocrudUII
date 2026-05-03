import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LuxuryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LuxuryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFD4AF37),
        side: const BorderSide(color: Color(0xFFD4AF37), width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
