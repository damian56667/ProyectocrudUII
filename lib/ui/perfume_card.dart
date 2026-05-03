import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfumeCard extends StatelessWidget {
  final String nombre;
  final String genero;
  final double precioCompra;
  final double precioVenta;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PerfumeCard({
    super.key,
    required this.nombre,
    required this.genero,
    required this.precioCompra,
    required this.precioVenta,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final double margen = precioVenta - precioCompra;

    return Card(
      color: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFFD4AF37), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    nombre,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Color(0xFFD4AF37)),
                      onPressed: onEdit,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: onDelete,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Género: $genero',
              style: GoogleFonts.lato(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const Divider(color: Color(0xFFD4AF37)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Compra: \$${precioCompra.toStringAsFixed(2)}',
                      style: GoogleFonts.lato(fontSize: 14, color: Colors.red[800]),
                    ),
                    Text(
                      'Venta: \$${precioVenta.toStringAsFixed(2)}',
                      style: GoogleFonts.lato(fontSize: 14, color: Colors.green[800]),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Margen',
                      style: GoogleFonts.lato(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      '\$${margen.toStringAsFixed(2)}',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFD4AF37),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
