class Viagem {
  final String id;
  final double kmRodados;
  final double valorFrete;
  final DateTime data;

  Viagem({
    required this.id,
    required this.kmRodados,
    required this.valorFrete,
    required this.data,
  });

  double get ganhos => kmRodados * valorFrete;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kmRodados': kmRodados,
      'valorFrete': valorFrete,
      'data': data.toIso8601String(),
    };
  }

  factory Viagem.fromJson(Map<String, dynamic> json) {
    return Viagem(
      id: json['id'],
      kmRodados: json['kmRodados'],
      valorFrete: json['valorFrete'],
      data: DateTime.parse(json['data']),
    );
  }
}

