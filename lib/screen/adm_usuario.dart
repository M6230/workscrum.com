import 'package:flutter/material.dart';
import '../model/usuario.dart';
import '../services/usuario_service.dart';

class AdmUsuario extends StatefulWidget {
  const AdmUsuario({super.key});

  @override
  State<AdmUsuario> createState() => _AdmUsuarioState();
}

class _AdmUsuarioState extends State<AdmUsuario> {
  final UsuarioService usuarioService = UsuarioService();
  late Future<List<Usuarios>> _listaUsuarios;

  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  void _cargarUsuarios() {
    setState(() {
      _listaUsuarios = usuarioService.getUsuarios(); // ACTUALIZA visualmente
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
            color: Color.fromARGB(255, 1, 67, 154),
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
                  'Usuarios',
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
        backgroundColor: const Color.fromARGB(255, 1, 67, 154),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/usuarios/crear');
          if (result == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Usuario creado exitosamente'),
                duration: Duration(seconds: 2),
              ),
            );
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
      body: FutureBuilder<List<Usuarios>>(
        future: _listaUsuarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF003366)),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final usuarios = snapshot.data;

          if (usuarios == null || usuarios.isEmpty) {
            return const Center(child: Text("No hay usuarios registrados."));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              final usuario = usuarios[index];
              return Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 106, 130, 134),
                      Color.fromARGB(255, 151, 175, 178)
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
                    const Icon(Icons.person, color: Colors.black, size: 50),
                    const SizedBox(height: 10),
                    const Text(
                      'Nombre De Usuario',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                       fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${usuario.USU_NOMBRE} ${usuario.USU_APELLIDO}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.description, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        const Text(
                          'Correo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      usuario.USU_CORREO,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Rol',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Chip(
                      avatar: const Icon(Icons.verified_user,
                          size: 14, color: Colors.white),
                      label: Text(
                        usuario.USU_ROL,
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      backgroundColor: const Color.fromARGB(206, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
