import 'package:flutter/material.dart';
import 'modelos/producto.dart';
import 'pantallas/pantalla_lista.dart';
import 'pantallas/pantalla_agregar.dart';
import 'pantallas/pantalla_perfil.dart';

class PaginaInicio extends StatefulWidget {
  const PaginaInicio({super.key});

  @override
  State<PaginaInicio> createState() => _PaginaInicioEstado();
}

class _PaginaInicioEstado extends State<PaginaInicio> {
  int indiceActual = 0;

  List<Producto> productos = [];
  String nombreUsuario = "";

  void agregarProducto(Producto producto) {
    setState(() {
      productos.add(producto);
    });
  }

  void alternarComprado(int indice) {
    setState(() {
      productos[indice].comprado = !productos[indice].comprado;
    });
  }

  void eliminarProducto(int indice) {
    setState(() {
      productos.removeAt(indice);
    });
  }

  void actualizarNombre(String nombre) {
    setState(() {
      nombreUsuario = nombre;
    });
  }

  @override
  Widget build(BuildContext context) {
    final paginas = [
      PantallaLista(
        productos: productos,
        alternarComprado: alternarComprado,
        eliminarProducto: eliminarProducto,
        nombreUsuario: nombreUsuario,
      ),
      PantallaAgregar(agregarProducto: agregarProducto),
      PantallaPerfil(
        nombreInicial: nombreUsuario,
        guardarNombre: actualizarNombre,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
      ),
      body: paginas[indiceActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indiceActual,
        onTap: (i) => setState(() => indiceActual = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lista"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Agregar"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
