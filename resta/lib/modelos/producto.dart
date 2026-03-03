class Producto {
  String nombre;
  int cantidad;
  bool comprado;

  Producto({
    required this.nombre,
    required this.cantidad,
    this.comprado = false,
  });
}
