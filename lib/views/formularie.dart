import 'package:crud_app/models/client.dart';
import 'package:crud_app/providers/client_provider.dart';
import 'package:crud_app/views/clients_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Formulaire extends StatefulWidget {
  const Formulaire({Key? key}) : super(key: key);

  @override
  State<Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  final _formulario = GlobalKey<FormState>();
  final Map<String, String> _dadosFormulario = {};

  void _carregaDadosFormulario(Client cliente) {
    _dadosFormulario['id'] = cliente.id;
    _dadosFormulario['nome'] = cliente.nome;
    _dadosFormulario['idade'] = cliente.idade.toString(); // Adicionado
    _dadosFormulario['sobrenome'] = cliente.sobrenome;
    _dadosFormulario['email'] = cliente.email;
    _dadosFormulario['avatarURL'] = cliente.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de clientes'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formulario,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _dadosFormulario['nome'],
                        decoration: const InputDecoration(labelText: 'Nome'),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Nome Inválido';
                          }
                          if (valor.trim().length < 3) {
                            return 'Nome muito pequeno. No mínimo 3 letras';
                          }
                          return null;
                        },
                        onSaved: (valor) => _dadosFormulario['nome'] = valor!,
                      ),
                      TextFormField(
                        initialValue: _dadosFormulario['sobrenome'],
                        decoration:
                            const InputDecoration(labelText: 'Sobrenome'),
                        onSaved: (valor) =>
                            _dadosFormulario['sobrenome'] = valor!,
                      ),
                      TextFormField(
                        initialValue: _dadosFormulario['idade'],
                        decoration: const InputDecoration(labelText: 'Idade'),
                        keyboardType: TextInputType.number,
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Idade Inválida';
                          }
                          final idade = int.tryParse(valor);
                          if (idade == null || idade <= 0 || idade > 110) {
                            return 'Idade deve estar entre 1 e 110 anos';
                          }
                          return null;
                        },
                        onSaved: (valor) => _dadosFormulario['idade'] = valor!,
                      ),
                      TextFormField(
                        initialValue: _dadosFormulario['email'],
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Email Inválido';
                          }
                          return null;
                        },
                        onSaved: (valor) => _dadosFormulario['email'] = valor!,
                      ),
                      TextFormField(
                        initialValue: _dadosFormulario['avatarURL'],
                        decoration:
                            const InputDecoration(labelText: 'URL do Avatar'),
                        validator: (valor) {
                          return null;
                        },
                        onSaved: (valor) =>
                            _dadosFormulario['avatarURL'] = valor!,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        icon: Icon(Icons.save),
                        label: Text('Salvar'),
                        onPressed: () {
                          if (_formulario.currentState!.validate()) {
                            _formulario.currentState!.save();
                            final clientProvider = Provider.of<ClientProvider>(
                                context,
                                listen: false);

                            final client = Client(
                              id: _dadosFormulario['id'] ?? '',
                              nome: _dadosFormulario['nome']!,
                              idade: int.parse(
                                  _dadosFormulario['idade']!), // Alterado
                              sobrenome: _dadosFormulario['sobrenome']!,
                              email: _dadosFormulario['email']!,
                              avatarUrl: _dadosFormulario['avatarURL']!,
                            );
                            clientProvider.put(client);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ClientsList(),
          ),
        ],
      ),
    );
  }
}
