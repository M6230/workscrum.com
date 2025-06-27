class Sprint {
  final int SPR_ID;
  final String SPR_FCH_INICIO;
  final String SPR_FCH_FIN;
  final String SPR_OBJETIVO;
  final int PROY_ESTADO;
  final String PROY_UID;

  Sprint({
    required this.SPR_ID,
    required this.SPR_FCH_INICIO,
    required this.SPR_FCH_FIN,
    required this.SPR_OBJETIVO,
    required this.PROY_ESTADO,
    required this.PROY_UID,
  });

  factory Sprint.fromJson(Map<String, dynamic> json) {
    return Sprint(
      SPR_ID: int.parse(json['SPR_ID'].toString()),
      SPR_FCH_INICIO: json['SPR_FCH_INICIO'] ?? '',
      SPR_FCH_FIN: json['SPR_FCH_FIN'] ?? '',
      SPR_OBJETIVO: json['SPR_OBJETIVO'] ?? '',
      PROY_ESTADO: int.parse(json['SPR_ESTADO'].toString()),
      PROY_UID: json['PROY_UID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SPR_ID': SPR_ID,
      'SPR_FCH_INICIO': SPR_FCH_INICIO,
      'SPR_FCH_FIN': SPR_FCH_FIN,
      'SPR_OBJETIVO': SPR_OBJETIVO,
      'SPR_ESTADO': PROY_ESTADO,
      'PROY_UID': PROY_UID,
    };
  }
}
