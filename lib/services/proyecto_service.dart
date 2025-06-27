import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/proyecto.dart';
import '../utils/ruta.dart';

class ProyectoService {
  final String baseUrl = Ruta.Direccion;

  /// Listar todos los proyectos
  Future<List<Proyectos>>getProyectos() async {
    final response = await http.get(Uri.parse("$baseUrl/proyectos/mostrar"));
    if (response.statusCode == 200) {
      final List items = json.decode(response.body);
      return items.map((json) => Proyectos.fromJson(json)).toList();
    } else {
      throw ("Error al cargar proyectos");
    }
  }

  /// Crear un nuevo proyecto
  Future<String> crearProyectos({
    required String PROY_NOMBRE,
    required String PROY_DESCRIPCION,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/proyectos/crear"),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({
        'PROY_NOMBRE': PROY_NOMBRE,
        'PROY_DESCRIPCION': PROY_DESCRIPCION,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonBody = json.decode(response.body);
      return jsonBody['mensaje'] ?? 'Registro exitoso';
    } else {
      final errorBody = json.decode(response.body);
      throw(errorBody['mensaje'] ?? 'Error al registrar proyecto');
    }
  }
} 

