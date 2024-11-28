import 'package:flutter/material.dart';
import '../screens/frete_screen.dart';
import '../screens/gastos_screen.dart';
import '../screens/configurar_frete_screen.dart';
import '../screens/descricoes_padrao_screen.dart';

class ResponsiveMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.menu),
      onSelected: (String result) {
        switch (result) {
          case 'viagem':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FreteScreen()),
            );
            break;
          case 'gasto':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GastosScreen()),
            );
            break;
          case 'frete':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConfigurarFreteScreen()),
            );
            break;
          case 'descricoes':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DescricoesPadraoScreen()),
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'viagem',
          child: Text('Adicionar Viagem'),
        ),
        const PopupMenuItem<String>(
          value: 'gasto',
          child: Text('Adicionar Gasto'),
        ),
        const PopupMenuItem<String>(
          value: 'frete',
          child: Text('Configurar Valor do Frete'),
        ),
        const PopupMenuItem<String>(
          value: 'descricoes',
          child: Text('Gerenciar Descrições Padrão'),
        ),
      ],
    );
  }
}

