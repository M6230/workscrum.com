
class Proyectos {
  final int PROY_ID;
  final String PROY_NOMBRE;
  final String PROY_DESCRIPCION;
  final int PROY_ESTADO;
  final String PROY_UID;

  Proyectos({
    required this.PROY_ID,
    required this.PROY_NOMBRE,
    required this.PROY_DESCRIPCION,
    required this.PROY_ESTADO,
    required this.PROY_UID,
  });
  
  factory Proyectos.fromJson(Map<String, dynamic> json) {
    return Proyectos(
      PROY_ID: int.parse(json['PROY_ID'].toString()),
      PROY_NOMBRE: json['PROY_NOMBRE'] ?? '',
      PROY_DESCRIPCION: json['PROY_DESCRIPCION'] ?? '',
      PROY_ESTADO: int.parse(json['PROY_ESTADO'].toString()),
      PROY_UID: json['PROY_UID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PROY_ID': PROY_ID,
      'PROY_NOMBRE': PROY_NOMBRE,
      'PROY_DESCRIPCION': PROY_DESCRIPCION,
      'PROY_ESTADO': PROY_ESTADO,
      'PROY_UID': PROY_UID,
    };
  }
}
