import 'package:flutter/material.dart';
import '../services/usuario_service.dart';

class inicio extends StatefulWidget {
  const inicio({super.key});

  @override
  State<inicio> createState() => _InicioState();
}

class _InicioState extends State<inicio> {
  final UsuarioService usuarioService = UsuarioService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 56, 58, 59),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Inicio',
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
                      icon: const Icon(Icons.logout, color: Colors.white),
                      tooltip: 'Cerrar sesión',
                      onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // ---------- BODY CON WIDGETS DE NAVEGACIÓN ----------
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildNavCard(
              context,
              icon: Icons.people_alt,
              label: 'Usuarios',
              color: const Color.fromARGB(255, 1, 67, 154),
              route: '/',
            ),
            _buildNavCard(
              context,
              icon: Icons.work,
              label: 'Proyectos',
              color: const Color.fromARGB(255, 10, 194, 255),
              route: '/proyectos',
            ),
            _buildNavCard(
              context,
              icon: Icons.description,
              label: 'Sprints',
              color: const Color.fromARGB(255, 1, 94, 115),
              route: '/sprints',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavCard(BuildContext context,
      {required IconData icon,
      required String label,
      required Color color,
      required String route,
      bool isReplacement = false}) {
    return GestureDetector(
      onTap: () {
        if (isReplacement) {
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        color: color,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
