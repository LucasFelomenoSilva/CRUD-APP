// ignore_for_file: must_be_immutable

import 'package:crud_app/components/products_widget.dart';
import 'package:crud_app/models/product.dart';
import 'package:crud_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatelessWidget {
  Map<String, String> _dadosFormulariop = {};

  ProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductProvider produtos = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('Lista de produtos'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: produtos.contador,
        itemBuilder: (ctx, i) => ProductWidget(
          produto: produtos.peloIndice(i),
          onEdit: () {
            _carregaDadosFormulariop(produtos.peloIndice(i));
          },
        ),
      ),
    );
  }

  void _carregaDadosFormulariop(Product produto) {
    _dadosFormulariop['id'] = produto.id;
    _dadosFormulariop['produto'] = produto.produto;
    _dadosFormulariop['descricao'] = produto.descricao;
    _dadosFormulariop['foto'] = produto.foto;
  }
}
