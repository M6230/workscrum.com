import 'package:flutter/material.dart';
import '../services/sprint_service.dart';

class CrearSprint extends StatefulWidget {
  const CrearSprint({super.key});

  @override
  State<CrearSprint> createState() => _CrearSprintState();
}

class _CrearSprintState extends State<CrearSprint> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _inicioController = TextEditingController();
  final TextEditingController _finController = TextEditingController();
  final SprintService sprintService = SprintService();

  String estado = 'Activo';

  Future<void> _guardarSprint() async {
    if (_formKey.currentState!.validate()) {
      try {
        final mensaje = await sprintService.crearSprint(
          nombre: _nombreController.text,
          fechaInicio: _inicioController.text,
          fechaFin: _finController.text,
          estado: estado == 'Activo' ? '1' : '0',
        );

        // Limpio los campos
        _nombreController.clear();
        _inicioController.clear();
        _finController.clear();
        _formKey.currentState?.reset();

        // Muestro la notificación con el mensaje recibido
        _mostrarNotificacion(context, mensaje);
      } catch (e) {
        _mostrarNotificacion(context, "Error: $e");
      }
    }
  }

  void _mostrarNotificacion(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 6, 78, 116),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text("Notificación", style: TextStyle(color: Colors.white)),
        content: Text(mensaje, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);      // Cierra el diálogo
              Navigator.pop(context, true); // Vuelve a pantalla anterior con resultado true
            },
            child: const Text("Aceptar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  String? _validarFecha(String? value) {
    if (value == null || value.isEmpty) return "Campo obligatorio";
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(value)) return "Formato: YYYY-MM-DD";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Nuevo Sprint"),
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        elevation: 0,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Registrar Sprint",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E5558),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Nombre (Objetivo)
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      labelText: "Objetivo",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.flag,
                        color: Color.fromARGB(255, 23, 198, 237),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (value) => value!.isEmpty ? "Campo obligatorio" : null,
                  ),
                  const SizedBox(height: 16),

                  // Fecha inicio
                  TextFormField(
                    controller: _inicioController,
                    decoration: const InputDecoration(
                      labelText: "Fecha de Inicio (YYYY-MM-DD)",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Color.fromARGB(255, 23, 198, 237),
                      ),
                    ),
                    validator: _validarFecha,
                  ),
                  const SizedBox(height: 16),

                  // Fecha fin
                  TextFormField(
                    controller: _finController,
                    decoration: const InputDecoration(
                      labelText: "Fecha de Fin (YYYY-MM-DD)",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.calendar_today_outlined,
                        color: Color.fromARGB(255, 23, 198, 237),
                      ),
                    ),
                    validator: _validarFecha,
                  ),
                  const SizedBox(height: 24),

                  // Botón
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Crear Sprint",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _guardarSprint,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 72, 144),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
