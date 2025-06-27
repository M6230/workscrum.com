import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/sprint.dart';
import '../utils/ruta.dart';

class SprintService {
  final String baseUrl = Ruta.Direccion;

  /// Listar todos los sprints
  Future<List<Sprint>> getSprints() async {
    final response = await http.get(Uri.parse("$baseUrl/sprints/mostrar"));
    if (response.statusCode == 200) {
      final List items = json.decode(response.body);
      return items.map((json) => Sprint.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar sprints");
    }
  }

  /// Crear un nuevo sprint
  Future<String> crearSprint({
    required String nombre,
    required String fechaInicio,
    required String fechaFin,
    required String estado,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/sprints/crear"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'SPR_OBJETIVO': nombre,
        'SPR_FCH_INICIO': fechaInicio,
        'SPR_FCH_FIN': fechaFin,
        'SPR_ESTADO': estado,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonBody = json.decode(response.body);
      return jsonBody['mensaje'] ?? 'Sprint creado correctamente';
    } else {
      final errorBody = json.decode(response.body);
      throw Exception(errorBody['mensaje'] ?? 'Error al crear el sprint');
    }
  }

  
}