class TipoPokemon {
  final String nombre;
  final List<String> debilidades; 

  TipoPokemon({
    required this.nombre,
    required this.debilidades,
  });

  factory TipoPokemon.desdeJson(Map<String, dynamic> json) {
   
    var relacionesDano = json['damage_relations']['double_damage_from'] as List;
    List<String> listaDebilidades = relacionesDano
        .map((elemento) => elemento['name'] as String)
        .toList();

    return TipoPokemon(
      nombre: json['name'],
      debilidades: listaDebilidades,
    );
  }
}