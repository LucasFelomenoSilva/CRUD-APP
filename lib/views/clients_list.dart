// ignore_for_file: must_be_immutable

import 'package:crud_app/components/client_widget.dart';
import 'package:crud_app/models/client.dart';
import 'package:crud_app/providers/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientsList extends StatelessWidget {
  Map<String, String> _dadosFormulario = {};

  ClientsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ClientProvider clientes = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('Lista de clientes'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: clientes.contador,
        itemBuilder: (ctx, i) => ClientWidget(
          cliente: clientes.peloIndice(i),
          onEdit: () {
            _carregaDadosFormulario(clientes.peloIndice(i));
          },
        ),
      ),
    );
  }

  void _carregaDadosFormulario(Client cliente) {
    _dadosFormulario['id'] = cliente.id;
    _dadosFormulario['nome'] = cliente.nome;
    _dadosFormulario['sobrenome'] = cliente.sobrenome;
    _dadosFormulario['email'] = cliente.email;
    _dadosFormulario['avatarURL'] = cliente.avatarUrl;
  }
}
