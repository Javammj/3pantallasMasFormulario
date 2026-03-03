import 'package:flutter/material.dart';

class PantallaPerfil extends StatefulWidget {
  final String nombreInicial;
  final void Function(String) guardarNombre;

  const PantallaPerfil({
    super.key,
    required this.nombreInicial,
    required this.guardarNombre,
  });

  @override
  State<PantallaPerfil> createState() => _PantallaPerfilEstado();
}

class _PantallaPerfilEstado extends State<PantallaPerfil> {
  final _formKey = GlobalKey<FormState>();
  late String nombre;

  @override
  void initState() {
    super.initState();
    nombre = widget.nombreInicial;
  }

  void guardar() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.guardarNombre(nombre);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nombre actualizado")),
      );
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
              "Perfil",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: nombre,
              decoration: const InputDecoration(
                labelText: "Nombre de usuario",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? "Ingresa un nombre" : null,
              onSaved: (v) => nombre = v!.trim(),
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
