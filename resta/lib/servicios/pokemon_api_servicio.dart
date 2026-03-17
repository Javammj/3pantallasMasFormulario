import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../modelos/tipo_pokemon.dart';

class PokemonApiServicio {
  static const String _urlBase = 'https://pokeapi.co/api/v2';

  static Future<TipoPokemon> obtenerTipoAleatorio() async {
  
    final int idIdal = Random().nextInt(18) + 1;
    final url = Uri.parse('$_urlBase/type/$idIdal');

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return TipoPokemon.desdeJson(jsonDecode(respuesta.body));
      } else {
        throw Exception('Error al conectar con la PokeAPI');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}