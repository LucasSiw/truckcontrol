import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/viagem_provider.dart';

class GastosScreen extends StatefulWidget {
  @override
  _GastosScreenState createState() => _GastosScreenState();
}

class _GastosScreenState extends State<GastosScreen> {
  final _formKey = GlobalKey<FormState>();
  String _descricao = '';
  double _valor = 0;
  bool _descricaoCustom = false;

  @override
  Widget build(BuildContext context) {
    final viagemProvider = Provider.of<ViagemProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Gasto')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (!_descricaoCustom)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Descrição do Gasto'),
                  items: [
                    ...viagemProvider.descricoesPadrao.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }),
                    DropdownMenuItem<String>(
                      value: 'custom',
                      child: Text('Outra descrição...'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == 'custom') {
                      setState(() {
                        _descricaoCustom = true;
                      });
                    } else {
                      setState(() {
                        _descricao = value!;
                      });
                    }
                  },
                ),
              if (_descricaoCustom)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Descrição do Gasto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a descrição do gasto';
                    }
                    return null;
                  },
                  onSaved: (value) => _descricao = value!,
                ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Valor do Gasto'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor do gasto';
                  }
                  return null;
                },
                onSaved: (value) => _valor = double.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitGasto,
                child: Text('Adicionar Gasto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitGasto() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final viagemProvider = Provider.of<ViagemProvider>(context, listen: false);
      viagemProvider.adicionarGasto(_descricao, _valor);
      Navigator.pop(context);
    }
  }
}

