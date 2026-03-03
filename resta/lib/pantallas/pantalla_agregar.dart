import 'package:flutter/material.dart';
import '../modelos/producto.dart';

class PantallaAgregar extends StatefulWidget {
  final void Function(Producto) agregarProducto;

  const PantallaAgregar({super.key, required this.agregarProducto});

  @override
  State<PantallaAgregar> createState() => _PantallaAgregarEstado();
}

class _PantallaAgregarEstado extends State<PantallaAgregar> {
  final _formKey = GlobalKey<FormState>();

  String nombre = "";
  int cantidad = 1;

  void guardar() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      widget.agregarProducto(
        Producto(nombre: nombre, cantidad: cantidad),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Producto agregado")),
      );

      _formKey.currentState!.reset();
      setState(() => cantidad = 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text(
              "Agregar producto",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Nombre del producto",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? "Ingresa un nombre" : null,
              onSaved: (v) => nombre = v!.trim(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Cantidad",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              initialValue: "1",
              validator: (v) {
                final n = int.tryParse(v ?? "");
                return (n == null || n <= 0) ? "Cantidad inválida" : null;
              },
              onSaved: (v) => cantidad = int.parse(v!),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: guardar,
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
