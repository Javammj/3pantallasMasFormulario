import 'package:flutter/material.dart';
import 'dart:math';
import '../modelos/tipo_pokemon.dart';
import '../servicios/pokemon_api_servicio.dart';
import '../constantes/colores_tipos.dart';

class JuegoTiposPantalla extends StatefulWidget {
  const JuegoTiposPantalla({super.key});

  @override
  State<JuegoTiposPantalla> createState() => _JuegoTiposPantallaState();
}

class _JuegoTiposPantallaState extends State<JuegoTiposPantalla> {
  TipoPokemon? _tipoObjetivo;
  List<String> _opciones = [];
  bool _cargando = true;

  final List<String> _todosLosTipos = [
    'normal', 'fire', 'water', 'grass', 'electric', 'ice', 'fighting', 'poison',
    'ground', 'flying', 'psychic', 'bug', 'rock', 'ghost', 'dragon', 'dark', 'steel', 'fairy'
  ];

  @override
  void initState() {
    super.initState();
    _nuevaPregunta();
  }

  Future<void> _nuevaPregunta() async {
    setState(() => _cargando = true);
    try {
      final tipo = await PokemonApiServicio.obtenerTipoAleatorio();
      if (tipo.debilidades.isEmpty) return _nuevaPregunta();

      String correcta = tipo.debilidades[Random().nextInt(tipo.debilidades.length)];
      
      List<String> incorrectas = _todosLosTipos
          .where((t) => t != correcta && !tipo.debilidades.contains(t))
          .toList();
      incorrectas.shuffle();

      setState(() {
        _tipoObjetivo = tipo;
        _opciones = [correcta, ...incorrectas.take(3)];
        _opciones.shuffle();
        _cargando = false;
      });
    } catch (e) {
      _mostrarMensaje("Error al cargar datos");
    }
  }

  void _validarRespuesta(String seleccion) {
    bool esCorrecto = _tipoObjetivo!.debilidades.contains(seleccion);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(esCorrecto ? "¡Excelente!" : "¡Oh no!"),
        content: Text(esCorrecto 
          ? "¡$seleccion es muy eficaz contra ${_tipoObjetivo!.nombre}!" 
          : "$seleccion no es una debilidad de ${_tipoObjetivo!.nombre}."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _nuevaPregunta();
            },
            child: const Text("Siguiente"),
          )
        ],
      ),
    );
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maestro de Tipos"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: _cargando 
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "¿Qué tipo le gana a?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    decoration: BoxDecoration(
                      color: ColoresTipos.obtenerColor(_tipoObjetivo!.nombre),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Text(
                      _tipoObjetivo!.nombre.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 350), 
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2.5, 
                      children: _opciones.map((opcion) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColoresTipos.obtenerColor(opcion),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () => _validarRespuesta(opcion),
                        child: Text(
                          opcion.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      )).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
    );
  }
}