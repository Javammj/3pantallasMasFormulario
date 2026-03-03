import 'package:flutter/material.dart';
import '../modelos/producto.dart';

class PantallaLista extends StatelessWidget {
  final List<Producto> productos;
  final void Function(int) alternarComprado;
  final void Function(int) eliminarProducto;
  final String nombreUsuario;

  const PantallaLista({
    super.key,
    required this.productos,
    required this.alternarComprado,
    required this.eliminarProducto,
    required this.nombreUsuario,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Hola, $nombreUsuario 👋",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        Expanded(
          child: productos.isEmpty
              ? const Center(child: Text("No hay productos agregados."))
              : ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, indice) {
                    final producto = productos[indice];
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: producto.comprado,
                          onChanged: (_) => alternarComprado(indice),
                        ),
                        title: Text(
                          "${producto.nombre} (x${producto.cantidad})",
                          style: TextStyle(
                            decoration: producto.comprado
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => eliminarProducto(indice),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
