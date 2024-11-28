import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/viagem_provider.dart';

class DescricoesPadraoScreen extends StatefulWidget {
  @override
  _DescricoesPadraoScreenState createState() => _DescricoesPadraoScreenState();
}

class _DescricoesPadraoScreenState extends State<DescricoesPadraoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _novaDescricao = '';

  @override
  Widget build(BuildContext context) {
    final viagemProvider = Provider.of<ViagemProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Descrições Padrão')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Nova Descrição'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma descrição';
                        }
                        return null;
                      },
                      onSaved: (value) => _novaDescricao = value!,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _adicionarDescricao,
                    child: Text('Adicionar'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: viagemProvider.descricoesPadrao.length,
                itemBuilder: (context, index) {
                  final descricao = viagemProvider.descricoesPadrao[index];
                  return ListTile(
                    title: Text(descricao),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => viagemProvider.removerDescricaoPadrao(descricao),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _adicionarDescricao() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<ViagemProvider>(context, listen: false).adicionarDescricaoPadrao(_novaDescricao);
      _formKey.currentState!.reset();
    }
  }
}

