import 'package:flutter/material.dart';
import '../model/proyecto.dart';
import '../services/proyecto_service.dart';

class CrearProyecto extends StatefulWidget {
  const CrearProyecto({super.key});

  @override
  State<CrearProyecto> createState() => _CrearProyectoState();
}

class _CrearProyectoState extends State<CrearProyecto> {
  final _formKey = GlobalKey<FormState>();
  final ProyectoService _proyectoService = ProyectoService();
  final TextEditingController ctnNombre = TextEditingController();
  final TextEditingController ctnDescripcion = TextEditingController();

  bool _isLoading = false;

  Future<void> registrarProyecto() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) return;

    try {
      final nuevoProyecto = Proyectos(
        PROY_ID: 0,
        PROY_NOMBRE: ctnNombre.text.trim(),
        PROY_DESCRIPCION: ctnDescripcion.text.trim(),
        PROY_ESTADO: 1,
        PROY_UID: '',
      );

      String mensaje = await _proyectoService.crearProyectos(
        PROY_NOMBRE: nuevoProyecto.PROY_NOMBRE,
        PROY_DESCRIPCION: nuevoProyecto.PROY_DESCRIPCION,
      );

      ctnNombre.clear();
      ctnDescripcion.clear();
      _formKey.currentState?.reset();

      _mostrarNotificacion(context, mensaje);
    } catch (e) {
      _mostrarNotificacion(context, 'Error: ${e.toString()}');
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
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            child: const Text("Aceptar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Nuevo Proyecto",
          style: TextStyle(color: Color.fromARGB(255, 6, 6, 6)),
        ),
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
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Text(
                    "Registrar Proyecto",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E5558),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  campoAnimado(
                    label: 'Nombre del Proyecto',
                    controller: ctnNombre,
                    icono: Icons.work,
                  ),
                  campoAnimado(
                    label: 'Descripción',
                    controller: ctnDescripcion,
                    icono: Icons.description,
                    tipo: TextInputType.multiline,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add_box, color: Colors.white),
                      label: const Text(
                        "Registrar Proyecto",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _isLoading ? null : registrarProyecto,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004890),
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

  Widget campoAnimado({
    required String label,
    required TextEditingController controller,
    IconData? icono,
    TextInputType tipo = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: tipo,
        maxLines: tipo == TextInputType.multiline ? null : 1,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icono != null
              ? Icon(icono, color: const Color.fromARGB(255, 23, 198, 237))
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        validator: (value) => (value == null || value.isEmpty) ? 'Ingrese $label' : null,
      ),
    );
  }
}
