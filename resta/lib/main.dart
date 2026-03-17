import 'package:flutter/material.dart';
import 'pantallas/juego_tipos_pantalla.dart';

void main() {
  runApp(const MiAppPokemon());
}

class MiAppPokemon extends StatelessWidget {
  const MiAppPokemon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia de Tipos Pokemon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const JuegoTiposPantalla(),
    );
  }
}
