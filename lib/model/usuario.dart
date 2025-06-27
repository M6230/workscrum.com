class Usuarios {
  final int USU_ID;
  final String USU_NOMBRE;
  final String USU_APELLIDO;
  final String USU_CORREO;
  final String USU_ROL;
  final int USU_ESTADO;
  final String USU_CONTRASENA;
  final String USU_UID;

  Usuarios({
    required this.USU_ID,
    required this.USU_NOMBRE,
    required this.USU_APELLIDO,
    required this.USU_CORREO,
    required this.USU_ROL,
    required this.USU_ESTADO,
    required this.USU_CONTRASENA,
    required this.USU_UID,
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) {
    return Usuarios(
      USU_ID: int.parse(json['USU_ID'].toString()),
      USU_NOMBRE: json['USU_NOMBRE'] ?? '',
      USU_APELLIDO: json['USU_APELLIDO'] ?? '',
      USU_CORREO: json['USU_CORREO'] ?? '',
      USU_ROL: json['USU_ROL'] ?? '',
      USU_CONTRASENA: json['USU_CONTRASENA'] ?? '',
      USU_ESTADO: int.parse(json['USU_ESTADO'].toString()),
      USU_UID: json['USU_UID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'USU_ID': USU_ID,
      'USU_NOMBRE': USU_NOMBRE,
      'USU_APELLIDO': USU_APELLIDO,
      'USU_CORREO': USU_CORREO,
      'USU_ROL': USU_ROL,
      'USU_CONTRASENA': USU_CONTRASENA,
      'USU_ESTADO': USU_ESTADO,
      'USU_UID': USU_UID,
    };
  }
}
