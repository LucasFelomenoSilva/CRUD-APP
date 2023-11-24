import 'package:crud_app/models/product.dart';
import 'package:crud_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final Product produto;

  final VoidCallback onEdit;

  const ProductWidget({
    Key? key,
    required this.produto,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = produto.foto.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(produto.foto));
    return ListTile(
      leading: avatar,
      title: Text("${produto.produto}"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Descrição: ${produto.descricao}'),
          Text('Preço: R\$ ${produto.preco.toStringAsFixed(2)}'),
        ],
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                onEdit();
              },
              icon: const Icon(Icons.edit),
              color: Colors.orange,
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Excluir Produto'),
                      content: const Text('Tem certeza?'),
                      actions: <Widget>[
                        FloatingActionButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Não'),
                        ),
                        FloatingActionButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Sim'),
                        )
                      ],
                    ),
                  ).then((confirmado) => {
                        if (confirmado)
                          {
                            Provider.of<ProductProvider>(context, listen: false)
                                .remove(produto.id)
                          }
                      });
                },
                icon: const Icon(Icons.delete),
                color: Colors.red),
          ],
        ),
      ),
    );
  }
}
