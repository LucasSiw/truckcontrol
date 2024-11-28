import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/viagem_provider.dart';

class FreteScreen extends StatefulWidget {
  @override
  _FreteScreenState createState() => _FreteScreenState();
}

class _FreteScreenState extends State<FreteScreen> {
  final _formKey = GlobalKey<FormState>();
  double _kmRodados = 0;

  @override
  Widget build(BuildContext context) {
    final viagemProvider = Provider.of<ViagemProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Viagem')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Valor do Frete Fixo: R\$ ${viagemProvider.valorFreteFixo.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'KM Rodados'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira os KM rodados';
                  }
                  return null;
                },
                onSaved: (value) => _kmRodados = double.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitViagem,
                child: Text('Adicionar Viagem'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitViagem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final viagemProvider = Provider.of<ViagemProvider>(context, listen: false);
      viagemProvider.adicionarViagem(_kmRodados);
      Navigator.pop(context);
    }
  }
}

