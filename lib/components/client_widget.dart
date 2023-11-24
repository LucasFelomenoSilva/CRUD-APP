import 'package:crud_app/models/client.dart';
import 'package:crud_app/providers/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientWidget extends StatelessWidget {
  final Client cliente;
  final VoidCallback onEdit;

  const ClientWidget({
    Key? key,
    required this.cliente,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = cliente.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(cliente.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text("${cliente.nome} ${cliente.sobrenome}"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cliente.email),
          Text('Idade: ${cliente.idade} anos'),
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
                      title: const Text('Excluir Cliente'),
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
                            Provider.of<ClientProvider>(context, listen: false)
                                .remove(cliente.id)
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
