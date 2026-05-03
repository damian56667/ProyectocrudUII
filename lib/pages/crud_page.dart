import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ui/custom_appbar.dart';
import '../ui/perfume_card.dart';
import '../ui/luxury_buttons.dart';

class CrudPage extends StatefulWidget {
  const CrudPage({super.key});

  @override
  State<CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  final CollectionReference _perfumes =
      FirebaseFirestore.instance.collection('perfumes');
  String _filtroGenero = 'Todos';

  Future<void> _crearOActualizar([DocumentSnapshot? documentSnapshot]) async {
    String accion = 'Crear';
    final _nombreController = TextEditingController();
    final _generoController = TextEditingController();
    final _precioCompraController = TextEditingController();
    final _precioVentaController = TextEditingController();

    if (documentSnapshot != null) {
      accion = 'Actualizar';
      _nombreController.text = documentSnapshot['nombre'];
      _generoController.text = documentSnapshot['genero'];
      _precioCompraController.text = documentSnapshot['precio_compra'].toString();
      _precioVentaController.text = documentSnapshot['precio_venta'].toString();
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$accion Perfume',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF000000),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: GoogleFonts.lato(),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD4AF37)),
                  ),
                ),
              ),
              TextField(
                controller: _generoController,
                decoration: InputDecoration(
                  labelText: 'Género (ej. Masculino, Femenino, Unisex)',
                  labelStyle: GoogleFonts.lato(),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD4AF37)),
                  ),
                ),
              ),
              TextField(
                controller: _precioCompraController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Precio de Compra',
                  labelStyle: GoogleFonts.lato(),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD4AF37)),
                  ),
                ),
              ),
              TextField(
                controller: _precioVentaController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Precio de Venta',
                  labelStyle: GoogleFonts.lato(),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD4AF37)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: LuxuryButton(
                  text: accion == 'Crear' ? 'GUARDAR' : 'ACTUALIZAR',
                  onPressed: () async {
                    final String nombre = _nombreController.text;
                    final String genero = _generoController.text;
                    final double? precioCompra =
                        double.tryParse(_precioCompraController.text);
                    final double? precioVenta =
                        double.tryParse(_precioVentaController.text);

                    if (nombre.isNotEmpty &&
                        genero.isNotEmpty &&
                        precioCompra != null &&
                        precioVenta != null) {
                      if (accion == 'Crear') {
                        await _perfumes.add({
                          "nombre": nombre,
                          "genero": genero,
                          "precio_compra": precioCompra,
                          "precio_venta": precioVenta,
                        });
                      } else {
                        await _perfumes.doc(documentSnapshot!.id).update({
                          "nombre": nombre,
                          "genero": genero,
                          "precio_compra": precioCompra,
                          "precio_venta": precioVenta,
                        });
                      }

                      _nombreController.text = '';
                      _generoController.text = '';
                      _precioCompraController.text = '';
                      _precioVentaController.text = '';

                      if (context.mounted) Navigator.of(context).pop();
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _borrarProducto(String productId) async {
    await _perfumes.doc(productId).delete();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Perfume eliminado exitosamente'),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Query query = _perfumes;
    if (_filtroGenero != 'Todos') {
      query = _perfumes.where('genero', isEqualTo: _filtroGenero);
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'Gestión de Perfumes'),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Filtrar por:',
                  style: GoogleFonts.lato(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: _filtroGenero,
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFD4AF37)),
                  style: GoogleFonts.lato(color: Colors.black, fontSize: 16),
                  onChanged: (String? newValue) {
                    setState(() {
                      _filtroGenero = newValue!;
                    });
                  },
                  items: <String>['Todos', 'Masculino', 'Femenino', 'Unisex']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: query.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
                  );
                }
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return PerfumeCard(
                        nombre: documentSnapshot['nombre'] ?? '',
                        genero: documentSnapshot['genero'] ?? '',
                        precioCompra: (documentSnapshot['precio_compra'] ?? 0).toDouble(),
                        precioVenta: (documentSnapshot['precio_venta'] ?? 0).toDouble(),
                        onEdit: () => _crearOActualizar(documentSnapshot),
                        onDelete: () => _borrarProducto(documentSnapshot.id),
                      );
                    },
                  );
                }
                return const Center(child: Text('No hay perfumes registrados.'));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _crearOActualizar(),
        backgroundColor: const Color(0xFF000000),
        child: const Icon(Icons.add, color: Color(0xFFD4AF37)),
      ),
    );
  }
}
