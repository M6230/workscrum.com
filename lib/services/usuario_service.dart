import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/usuario.dart';
import '../utils/ruta.dart';

class UsuarioService {
  final String baseUrl = Ruta.Direccion;

  /// Listar todos los usuarios
  Future<List<Usuarios>> getUsuarios() async {
    final response = await http.get(Uri.parse("$baseUrl/usuarios/mostrar"));
    if (response.statusCode == 200) {
      final List items = json.decode(response.body);
      return items.map((json) => Usuarios.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar usuarios");
    }
  }

  /// Crear un nuevo usuario
  Future<String> crearUsuarios({
    required String USU_NOMBRE,
    required String USU_APELLIDO,
    required String USU_CORREO,
    required String USU_CONTRASENA,
    required String USU_ROL,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/usuarios/crear"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'USU_NOMBRE': USU_NOMBRE,
        'USU_APELLIDO': USU_APELLIDO,
        'USU_CORREO': USU_CORREO,
        'USU_CONTRASENA': USU_CONTRASENA,
        'USU_ROL': USU_ROL,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonBody = json.decode(response.body);
      return jsonBody['mensaje'] ?? 'Registro exitoso';
    } else {
      final errorBody = json.decode(response.body);
      throw Exception(errorBody['mensaje'] ?? 'Error al registrar el usuario');
    }
  }
} 


  /// Actualizar un usuario existente
  // Future<String> editarUsuarios({
  //   required int USU_ID,
  //   required String USU_NOMBRE,
  //   required String USU_APELLIDO,
  //   required String USU_CORREO,
  //   required String USU_CONTRASENA,
  //   required String USU_ROL,
  // }) async {
  //   final response = await http.put(
  //     Uri.parse("$baseUrl/usuarios/editar/$USU_ID"),
  //     body: {
  //       'USU_NOMBRE': USU_NOMBRE,
  //       'USU_APELLIDO': USU_APELLIDO,
  //       'USU_CORREO': USU_CORREO,
  //       'USU_CONTRASENA': USU_CONTRASENA,
  //       'USU_ROL': USU_ROL,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final jsonBody = json.decode(response.body);
  //     return jsonBody['mensaje'] ?? 'Actualización exitosa';
  //   } else {
  //     throw Exception("Error al actualizar el usuario");
  //   }
  // }

  /// Eliminar un usuario por ID
//   Future<String> eliminarUsuarios(int USU_ID) async {
//     final response = await http.delete(Uri.parse("$baseUrl/usuarios/eliminar/$USU_ID"));

//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return jsonBody['mensaje'] ?? 'Eliminación exitosa';
//     } else {
//       throw Exception("Error al eliminar el usuario");
//     }
//   }
  /// Buscar un usuario por ID
//   Future<Usuarios> buscarUsuarioPorId(int USU_ID) async {
//     final response = await http.get(Uri.parse("$baseUrl/usuarios/mostrar/$USU_ID"));

//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return Usuarios.fromJson(jsonBody);
//     } else {
//       throw Exception("Error al buscar el usuario");
//     }
//   }
// }

  /// Buscar un usuario por correo
  // Future<Usuarios> buscarUsuarioPorCorreo(String USU_CORREO) async {
  //   var baseUrl;
  //   final response = await http.get(Uri.parse("$baseUrl/usuarios/buscar/$USU_CORREO"));

  //   if (response.statusCode == 200) {
  //     final jsonBody = json.decode(response.body);
  //     return Usuarios.fromJson(jsonBody);
  //   } else {
  //     throw Exception("Error al buscar el usuario por correo");
  //   }
  // }

  /// Buscar un usuario por nombre
  // Future<Usuarios> buscarUsuarioPorNombre(String USU_NOMBRE) async {
  //   var baseUrl;
  //   final response = await http.get(Uri.parse("$baseUrl/usuarios/buscar/$USU_NOMBRE"));

  //   if (response.statusCode == 200) {
  //     final jsonBody = json.decode(response.body);
  //     return Usuarios.fromJson(jsonBody);
  //   } else {
  //     throw Exception("Error al buscar el usuario por nombre");
  //   }
  // }
  // /// Buscar un usuario por apellido
  //  Future<Usuarios> buscarUsuarioPorApellido(String USU_APELLIDO) async {
  //   var baseUrl;
  //   final response = await http.get(Uri.parse("$baseUrl/usuarios/buscar/$USU_APELLIDO"));

  //   if (response.statusCode == 200) {
  //     final jsonBody = json.decode(response.body);
  //     return Usuarios.fromJson(jsonBody);
  //   } else {
  //     throw Exception("Error al buscar el usuario por apellido");
  //   }
  // }
  // /// Buscar un usuario por rol
  // Future<Usuarios> buscarUsuarioPorRol(String USU_ROL) async {
  //   var baseUrl;
  //   final response = await http.get(Uri.parse("$baseUrl/usuarios/buscar/$USU_ROL"));

  //   if (response.statusCode == 200) {
  //     final jsonBody = json.decode(response.body);
  //     return Usuarios.fromJson(jsonBody);
  //   } else {
  //     throw Exception("Error al buscar el usuario por rol");
  //   }
  // }
  // /// Buscar un usuario por estado
  //  Future<Usuarios> buscarUsuarioPorEstado(String USU_ESTADO) async {
  //   var baseUrl;
  //   final response = await http.get(Uri.parse("$baseUrl/usuarios/buscar/$USU_ESTADO"));

  //   if (response.statusCode == 200) {
  //     final jsonBody = json.decode(response.body);
  //     return Usuarios.fromJson(jsonBody);
  //   } else {
  //     throw Exception("Error al buscar el usuario por estado");
  //   }
  // }
  // /// Buscar un usuario por UID
  // Future<Usuarios> buscarUsuarioPorUid(String USU_UID) async {
  //   var baseUrl;
  //   final response = await http.get(Uri.parse("$baseUrl/usuarios/buscar/$USU_UID"));

  //   if (response.statusCode == 200) {
  //     final jsonBody = json.decode(response.body);
  //     return Usuarios.fromJson(jsonBody);
  //   } else {
  //     throw Exception("Error al buscar el usuario por UID");
  //   }
  // }
  // /// Buscar un usuario por ID y correo
  // // Future<Usuarios> buscarUsuarioPorIdCorreo(int USU_ID, String USU_CORREO) async {
  // //   var baseUrl;
  // //   final response = await http.get(Uri.parse("$baseUrl/usuarios/buscar/$USU_ID/$USU_CORREO"));

  // //   if (response.statusCode == 200) {
  // //     final jsonBody = json.decode(response.body);
  // //     return Usuarios.fromJson(jsonBody);
  // //   } else {
  // //     throw Exception("Error al buscar el usuario por ID y correo");
  // //   }
  // }

  /// Mostrar notificación en la pantalla
  // void _mostrarNotificacion(BuildContext context, String mensaje) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(mensaje),
  //       duration: const Duration(seconds: 2),
  //       action: SnackBarAction(
  //         label: 'Cerrar',
  //         onPressed: () {
  //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //         },
  //       ),
  //       backgroundColor: Colors.blue,
  //     )
  //   );
  // }

