import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/viagem_provider.dart';

class ConfigurarFreteScreen extends StatefulWidget {
  @override
  _ConfigurarFreteScreenState createState() => _ConfigurarFreteScreenState();
}

class _ConfigurarFreteScreenState extends State<ConfigurarFreteScreen> {
  final _formKey = GlobalKey<FormState>();
  double _novoValorFrete = 0;

  @override
  Widget build(BuildContext context) {
    final viagemProvider = Provider.of<ViagemProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Configurar Valor do Frete')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Valor Atual do Frete: R\$ ${viagemProvider.valorFreteFixo.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Novo Valor do Frete'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o novo valor do frete';
                  }
                  return null;
                },
                onSaved: (value) => _novoValorFrete = double.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _atualizarValorFrete,
                child: Text('Atualizar Valor do Frete'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _atualizarValorFrete() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final viagemProvider = Provider.of<ViagemProvider>(context, listen: false);
      viagemProvider.atualizarValorFreteFixo(_novoValorFrete);
      Navigator.pop(context);
    }
  }
}

