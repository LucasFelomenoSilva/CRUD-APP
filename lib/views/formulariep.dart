import 'package:crud_app/models/product.dart';
import 'package:crud_app/providers/product_provider.dart';
import 'package:crud_app/views/products_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Formulairep extends StatefulWidget {
  const Formulairep({Key? key}) : super(key: key);

  @override
  State<Formulairep> createState() => _FormulairepStatep();
}

class _FormulairepStatep extends State<Formulairep> {
  final _formulariop = GlobalKey<FormState>();
  final Map<String, String> _dadosFormulariop = {};

  void _carregaDadosFormulariop(Product produto) {
    _dadosFormulariop['id'] = produto.id;
    _dadosFormulariop['produto'] = produto.produto;
    _dadosFormulariop['descricao'] = produto.descricao;
    _dadosFormulariop['foto'] = produto.foto;
    _dadosFormulariop['preco'] = produto.preco.toString();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Object? produto = ModalRoute.of(context)!.settings.arguments;
    if (produto != null) {
      _carregaDadosFormulariop(produto as Product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de produtos'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formulariop,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _dadosFormulariop['produto'],
                        decoration:
                            const InputDecoration(labelText: 'Nome do produto'),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Nome Inválido';
                          }
                          if (valor.trim().length < 3) {
                            return 'Nome muito pequeno. No mínimo 2 letras';
                          }
                          return null;
                        },
                        onSaved: (valor) =>
                            _dadosFormulariop['produto'] = valor!,
                      ),
                      TextFormField(
                        initialValue: _dadosFormulariop['descricao'],
                        decoration: const InputDecoration(
                            labelText: 'Descrição do produto'),
                        validator: (valor) {
                          if (valor == null || valor.trim().isEmpty) {
                            return 'Descrição Inválida';
                          }
                          return null;
                        },
                        onSaved: (valor) =>
                            _dadosFormulariop['descricao'] = valor!,
                      ),
                      TextFormField(
                        initialValue: _dadosFormulariop['foto'],
                        decoration: const InputDecoration(
                            labelText: 'URL da foto do Produto'),
                        validator: (valor) {
                          return null;
                        },
                        onSaved: (valor) => _dadosFormulariop['foto'] = valor!,
                      ),
                      TextFormField(
                        initialValue: _dadosFormulariop['preco'],
                        decoration: const InputDecoration(
                          labelText: 'Preço do produto',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (valor) {
                          if (valor != null) {
                            double? preco = double.tryParse(valor);
                            if (preco == null || preco >= 120) {
                              return 'O preço deve ser menor que 120';
                            }
                          }
                          return null;
                        },
                        onSaved: (valor) => _dadosFormulariop['preco'] = valor!,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        icon: Icon(Icons.save),
                        label: Text('Salvar'),
                        onPressed: () {
                          if (_formulariop.currentState!.validate()) {
                            _formulariop.currentState!.save();
                            final productProvider =
                                Provider.of<ProductProvider>(context,
                                    listen: false);

                            final product = Product(
                              id: _dadosFormulariop['id'] ?? '',
                              produto: _dadosFormulariop['produto']!,
                              descricao: _dadosFormulariop['descricao']!,
                              foto: _dadosFormulariop['foto']!,
                              preco: double.parse(
                                  _dadosFormulariop['preco'] ?? '0.0'),
                            );
                            productProvider.put(product);
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
            child: ProductsList(),
          ),
        ],
      ),
    );
  }
}
