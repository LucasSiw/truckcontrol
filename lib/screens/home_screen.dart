import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/viagem_provider.dart';
import 'frete_screen.dart';
import 'gastos_screen.dart';
import 'configurar_frete_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Controle de Viagens')),
      body: Consumer<ViagemProvider>(
        builder: (context, viagemProvider, child) {
          final resumoMensal = _calcularResumoMensal(viagemProvider);
          return ListView(
            children: [
              _buildResumoMensal(resumoMensal),
              Divider(),
              _buildListaViagens(viagemProvider),
              Divider(),
              _buildListaGastos(viagemProvider),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showOptions(context),
        child: Icon(Icons.add),
        tooltip: 'Adicionar entrada ou saída',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildResumoMensal(Map<String, Map<String, double>> resumoMensal) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumo Mensal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...resumoMensal.entries.map((entry) {
              final mes = entry.key;
              final dados = entry.value;
              final saldo = dados['ganhos']! - dados['gastos']!;
              final cor = saldo >= 0 ? Colors.green : Colors.red;
              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(mes),
                    Text(
                      'R\$ ${saldo.toStringAsFixed(2)}',
                      style: TextStyle(color: cor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildListaViagens(ViagemProvider viagemProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Viagens',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: viagemProvider.viagens.length,
          itemBuilder: (context, index) {
            final viagem = viagemProvider.viagens[index];
            return ListTile(
              title: Text('Viagem ${index + 1}'),
              subtitle: Text('KM: ${viagem.kmRodados}, Ganhos: R\$ ${viagem.ganhos.toStringAsFixed(2)}'),
              trailing: Text(DateFormat('dd/MM/yyyy').format(viagem.data)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildListaGastos(ViagemProvider viagemProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Gastos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: viagemProvider.gastos.length,
          itemBuilder: (context, index) {
            final gasto = viagemProvider.gastos[index];
            return ListTile(
              title: Text(gasto.descricao),
              subtitle: Text('R\$ ${gasto.valor.toStringAsFixed(2)}'),
              trailing: Text(DateFormat('dd/MM/yyyy').format(gasto.data)),
            );
          },
        ),
      ],
    );
  }

  Map<String, Map<String, double>> _calcularResumoMensal(ViagemProvider viagemProvider) {
    Map<String, Map<String, double>> resumo = {};

    for (var viagem in viagemProvider.viagens) {
      final mes = DateFormat('MM/yyyy').format(viagem.data);
      resumo.putIfAbsent(mes, () => {'ganhos': 0, 'gastos': 0});
      resumo[mes]!['ganhos'] = (resumo[mes]!['ganhos'] ?? 0) + viagem.ganhos;
    }

    for (var gasto in viagemProvider.gastos) {
      final mes = DateFormat('MM/yyyy').format(gasto.data);
      resumo.putIfAbsent(mes, () => {'ganhos': 0, 'gastos': 0});
      resumo[mes]!['gastos'] = (resumo[mes]!['gastos'] ?? 0) + gasto.valor;
    }

    return resumo;
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add_circle),
                title: Text('Adicionar Viagem'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FreteScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.remove_circle),
                title: Text('Adicionar Gasto'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GastosScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configurar Valor do Frete'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConfigurarFreteScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

