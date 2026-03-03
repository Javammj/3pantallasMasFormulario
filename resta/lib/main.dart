import 'package:flutter/material.dart';
import 'pagina_inicio.dart';

void main() {
  runApp(const AplicacionCompras());
}

class AplicacionCompras extends StatelessWidget {
  const AplicacionCompras({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const PaginaInicio(),
    );
  }
}
