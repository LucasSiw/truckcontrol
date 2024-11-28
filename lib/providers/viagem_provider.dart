import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/viagem.dart';
import '../models/gasto.dart';

class ViagemProvider with ChangeNotifier {
  List<Viagem> _viagens = [];
  List<Gasto> _gastos = [];
  double _valorFreteFixo = 0;
  final SharedPreferences _prefs;

  ViagemProvider(this._prefs) {
    _carregarDados();
  }

  List<Viagem> get viagens => _viagens;
  List<Gasto> get gastos => _gastos;
  double get valorFreteFixo => _valorFreteFixo;

  void _carregarDados() {
    final viagensString = _prefs.getString('viagens');
    if (viagensString != null) {
      final viagensJson = jsonDecode(viagensString) as List;
      _viagens = viagensJson.map((e) => Viagem.fromJson(e)).toList();
    }

    final gastosString = _prefs.getString('gastos');
    if (gastosString != null) {
      final gastosJson = jsonDecode(gastosString) as List;
      _gastos = gastosJson.map((e) => Gasto.fromJson(e)).toList();
    }

    _valorFreteFixo = _prefs.getDouble('valorFreteFixo') ?? 0;

    notifyListeners();
  }

  Future<void> adicionarViagem(double kmRodados) async {
    final novaViagem = Viagem(
      id: DateTime.now().toString(),
      kmRodados: kmRodados,
      valorFrete: _valorFreteFixo,
      data: DateTime.now(),
    );
    _viagens.add(novaViagem);
    await _salvarViagens();
    notifyListeners();
  }

  Future<void> adicionarGasto(String descricao, double valor) async {
    final novoGasto = Gasto(
      id: DateTime.now().toString(),
      descricao: descricao,
      valor: valor,
      data: DateTime.now(),
    );
    _gastos.add(novoGasto);
    await _salvarGastos();
    notifyListeners();
  }

  Future<void> atualizarValorFreteFixo(double novoValor) async {
    _valorFreteFixo = novoValor;
    await _prefs.setDouble('valorFreteFixo', novoValor);
    notifyListeners();
  }

  Future<void> _salvarViagens() async {
    final viagensJson = _viagens.map((e) => e.toJson()).toList();
    await _prefs.setString('viagens', jsonEncode(viagensJson));
  }

  Future<void> _salvarGastos() async {
    final gastosJson = _gastos.map((e) => e.toJson()).toList();
    await _prefs.setString('gastos', jsonEncode(gastosJson));
  }
}

