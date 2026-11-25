
import 'package:flutter/material.dart';

void main() {
  runApp(const PedidoFlashApp());
}

class PedidoFlashApp extends StatelessWidget {
  const PedidoFlashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pedido Flash',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF8FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7950A0),
        ),
      ),
      home: const TelaInicial(),
    );
  }
}

class Produto {
  final String nome;
  final String preco;
  final IconData icone;

  const Produto({
    required this.nome,
    required this.preco,
    required this.icone,
  });
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  final List<Produto> produtos = const [
    Produto(
      nome: 'Pizza de calabresa com cebola e azeitonas',
      preco: 'R\$ 45,00',
      icone: Icons.local_pizza,
    ),
    Produto(
      nome: 'Suco de laranja',
      preco: 'R\$ 12,00',
      icone: Icons.local_cafe,
    ),
    Produto(
      nome: 'Hambúrguer duplo',
      preco: 'R\$ 32,00',
      icone: Icons.lunch_dining,
    ),
    Produto(
      nome: 'Pão de queijo',
      preco: 'R\$ 8,00',
      icone: Icons.bakery_dining,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8FF),
        title: const Text(
          'Pedido Flash',
          style: TextStyle(fontSize: 22),
        ),
      ),

      // Menu lateral
      drawer: Drawer(
        backgroundColor: const Color(0xFFF7F1FA),
        width: 330,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 115,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Menu Caixa',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const Divider(height: 1),

            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Novo pedido'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const Divider(height: 1),

            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Histórico'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const Divider(height: 1),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // Conteúdo principal
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cardápio rápido',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  final produto = produtos[index];

                  return Card(
                    elevation: 1,
                    color: const Color(0xFFF7F1FA),
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            produto.icone,
                            size: 25,
                            color: Colors.black87,
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Text(
                              produto.nome,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Text(
                            produto.preco,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
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
}
