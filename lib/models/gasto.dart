class Gasto {
  final String id;
  final String descricao;
  final double valor;
  final DateTime data;

  Gasto({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'data': data.toIso8601String(),
    };
  }

  factory Gasto.fromJson(Map<String, dynamic> json) {
    return Gasto(
      id: json['id'],
      descricao: json['descricao'],
      valor: json['valor'],
      data: DateTime.parse(json['data']),
    );
  }
}

