import 'package:flutter/material.dart';
import '../model/proyecto.dart';
import '../services/proyecto_service.dart';

class AdmProyectos extends StatefulWidget {
  const AdmProyectos({super.key});

  @override
  State<AdmProyectos> createState() => _AdmProyectoState();
}

class _AdmProyectoState extends State<AdmProyectos> {
  final ProyectoService proyectoService = ProyectoService();
  late Future<List<Proyectos>> _listaProyectos;

  @override
  void initState() {
    super.initState();
    _cargarProyectos();
  }

  void _cargarProyectos() {
    setState(() {
      _listaProyectos = proyectoService.getProyectos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 253, 253),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 10, 194, 255),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [BoxShadow(color: Color.fromARGB(66, 0, 0, 0))],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Proyectos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, color: Colors.white),
                      tooltip: 'Inicio',
                      onPressed: () => Navigator.pushNamed(context, '/inicio'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.people_alt, color: Colors.white),
                      tooltip: 'Usuarios',
                      onPressed: () => Navigator.pushNamed(context, '/'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.work, color: Colors.white),
                      tooltip: 'Proyectos',
                      onPressed: () => Navigator.pushNamed(context, '/proyectos'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.description, color: Colors.white),
                      tooltip: 'Sprints',
                      onPressed: () => Navigator.pushNamed(context, '/sprints'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 10, 194, 255),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/proyectos/crear');
          if (result == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Proyecto creado exitosamente'),
                duration: Duration(seconds: 2),
              ),
            );
            _cargarProyectos();  // Recarga la lista al volver
          }
        },
        label: const Text(
          "Agregar",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 235, 230, 230)),
        ),
        icon: const Icon(Icons.add, color: Color.fromARGB(255, 250, 250, 250)),
      ),
      body: FutureBuilder<List<Proyectos>>(
        future: _listaProyectos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF003366)),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final proyectos = snapshot.data;

          if (proyectos == null || proyectos.isEmpty) {
            return const Center(child: Text("No hay proyectos registrados."));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: proyectos.length,
            itemBuilder: (context, index) {
              final proyecto = proyectos[index];

              return Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 6, 6, 6),
                      Color.fromARGB(255, 9, 11, 12)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.work_outline, color: Color.fromARGB(255, 198, 197, 197), size: 50),

                    const Text(
                      'Nombre De Proyecto',
                      style: TextStyle(
                        color: Color.fromARGB(255, 74, 189, 255),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      proyecto.PROY_NOMBRE,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    // Aquí está el cambio para "Descripción" con icono y estilo igual
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.description, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        const Text(
                          'Descripción',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 179, 192),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      proyecto.PROY_DESCRIPCION,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
