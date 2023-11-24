import 'dart:math';

import 'package:crud_app/data/standard_product.dart';
import 'package:crud_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final Map<String, Product> _itens = {...STANDARD_PRODUCTS};

  List<Product> get todos {
    return [..._itens.values];
  }

  int get contador {
    return _itens.length;
  }

  Product peloIndice(int i) {
    return _itens.values.elementAt(i);
  }

  void put(Product produto) {
    if (produto.id.trim().isNotEmpty && _itens.containsKey(produto.id)) {
      _itens.update(produto.id, (_) => produto);
    } else {
      final id = Random().nextDouble().toString();
      _itens.putIfAbsent(
        id,
        () => Product(
          id: id,
          produto: produto.produto,
          descricao: produto.descricao,
          foto: produto.foto,
          preco: produto.preco,
        ),
      );
    }
    notifyListeners();
  }

  void remove(String id) {
    _itens.remove(id);
    notifyListeners();
  }
}
