import 'package:flutter/material.dart';
import '../model/sprint.dart';
import '../services/sprint_service.dart';

class AdmSprint extends StatefulWidget {
  const AdmSprint({super.key});

  @override
  State<AdmSprint> createState() => _AdmSprintState();
}

class _AdmSprintState extends State<AdmSprint> {
  final SprintService sprintService = SprintService();
  late Future<List<Sprint>> _listadoSprints;

  @override
  void initState() {
    super.initState();
    _cargarSprints();
  }

  void _cargarSprints() {
    setState(() {
      _listadoSprints = sprintService.getSprints(); //Recarga visual
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
            color: Color.fromARGB(255, 1, 94, 115),
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
                  'Sprints',
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
                      onPressed: () =>
                          Navigator.pushNamed(context, '/proyectos'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.description, color: Colors.white),
                      tooltip: 'sprints',
                      onPressed: () =>
                          Navigator.pushNamed(context, '/sprints'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 1, 94, 115),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/sprints/crear');
          if (result == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sprint creado exitosamente'),
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
      body: FutureBuilder<List<Sprint>>(
        future: _listadoSprints,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF003366)),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final sprints = snapshot.data;

          if (sprints == null || sprints.isEmpty) {
            return const Center(child: Text("No hay sprints registrados."));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: sprints.length,
            itemBuilder: (context, index) {
              final sprint = sprints[index];
              return Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color.fromARGB(255, 18, 230, 249), Color.fromARGB(255, 9, 111, 127)],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.flag, color: Color.fromARGB(255, 0, 0, 0), size:55),
                        SizedBox(width: 8),
                      ],
                    ),
                    
                   const SizedBox(height: 10),
                   const Center(
                    child: Text(
                      'Objetivo',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                    Center(
                      child: Text(
                        sprint.SPR_OBJETIVO,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                const SizedBox(height: 12),
                    const Text(
                      'Fecha Inicio',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Chip(
                      avatar: const Icon(Icons.calendar_today,
                          size: 14, color: Colors.white),
                      label: Text(
                        sprint.SPR_FCH_INICIO,
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      backgroundColor: const Color.fromARGB(203, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Fecha Fin',
                      style: TextStyle(
                        color: Color.fromARGB(255, 249, 249, 249),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Chip(
                      avatar: const Icon(Icons.calendar_today_outlined,
                          size: 14, color: Colors.white),
                      label: Text(
                        sprint.SPR_FCH_FIN,
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
