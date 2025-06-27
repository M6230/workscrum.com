import 'package:flutter/material.dart';
import '../model/usuario.dart';
import '../services/usuario_service.dart';

class CrearUsuario extends StatefulWidget {
  const CrearUsuario({super.key});

  @override
  State<CrearUsuario> createState() => _CrearUsuarioState();
}

class _CrearUsuarioState extends State<CrearUsuario> {
  final _formKey = GlobalKey<FormState>();
  final UsuarioService _usuarioService = UsuarioService();

  final TextEditingController ctnNombres = TextEditingController();
  final TextEditingController ctnApellidos = TextEditingController();
  final TextEditingController ctnCorreo = TextEditingController();
  final TextEditingController ctnContrasenia = TextEditingController();
  String? _rolSeleccionado;
  final List<String> _roles = ['Scrum Master', 'Scrum Team'];

  bool _isLoading = false;
  bool _isPressed = false;
  bool _isSuccess = false;

  Future<void> registrar() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) return;

    try {
      final nuevoUsuario = Usuarios(
        USU_ID: 0,
        USU_UID: '',
        USU_NOMBRE: ctnNombres.text.trim(),
        USU_APELLIDO: ctnApellidos.text.trim(),
        USU_CORREO: ctnCorreo.text.trim(),
        USU_CONTRASENA: ctnContrasenia.text.trim(),
        USU_ROL: _rolSeleccionado ?? '',
        USU_ESTADO: 1,
      );

      String mensaje = await _usuarioService.crearUsuarios(
        USU_NOMBRE: nuevoUsuario.USU_NOMBRE,
        USU_APELLIDO: nuevoUsuario.USU_APELLIDO,
        USU_CORREO: nuevoUsuario.USU_CORREO,
        USU_CONTRASENA: nuevoUsuario.USU_CONTRASENA,
        USU_ROL: nuevoUsuario.USU_ROL,
      );

      ctnNombres.clear();
      ctnApellidos.clear();
      ctnCorreo.clear();
      ctnContrasenia.clear();
      _rolSeleccionado = null;
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
              // Navigator.pop(context);
              // Navigator.pop(context, true);
              Navigator.pushNamed(context, '/');
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
          "Nuevo Usuario",
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
                    "Registrar Usuario",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E5558),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  campoAnimado(label: 'Nombres', controller: ctnNombres, icono: Icons.person),
                  campoAnimado(label: 'Apellidos', controller: ctnApellidos, icono: Icons.badge),
                  campoAnimado(label: 'Correo Electrónico', controller: ctnCorreo, icono: Icons.email, tipo: TextInputType.emailAddress),
                  campoAnimado(label: 'Contraseña', controller: ctnContrasenia, icono: Icons.lock, esPassword: true),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _rolSeleccionado,
                    items: [
                      ..._roles.map((rol) => DropdownMenuItem<String>(
                            value: rol,
                            child: Text(rol),
                          )),
                    ],
                    onChanged: (valor) => setState(() => _rolSeleccionado = valor),
                    decoration: InputDecoration(
                      labelText: 'Rol',
                      prefixIcon: const Icon(Icons.verified_user, color: Color(0xFF00ACC1)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                    validator: (value) => (value == null || value.isEmpty) ? 'Selecciona un rol' : null,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.person_add, color: Colors.white),
                      label: const Text(
                        "Registrar Usuario",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: _isLoading ? null : registrar,
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
    bool esPassword = false,
    TextInputType tipo = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: tipo,
        obscureText: esPassword,
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
