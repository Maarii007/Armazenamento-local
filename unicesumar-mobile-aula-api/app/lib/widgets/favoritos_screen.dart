import 'package:flutter/material.dart';
import '../data/database/app_database.dart';
import '../models/filme_item.dart';
import '../main.dart';

class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({super.key});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  final AppDatabase _db = AppDatabase();
  List<Favorito> _favoritos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarFavoritos();
  }

  Future<void> _carregarFavoritos() async {
    final lista = await _db.listarFavoritos();
    if (mounted) {
      setState(() {
        _favoritos = lista;
        _carregando = false;
      });
    }
  }

  Future<void> _removerFavorito(String titulo) async {
    await _db.removerFavorito(titulo);
    await _carregarFavoritos();
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true,
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _favoritos.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Nenhum favorito ainda.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _favoritos.length,
                  itemBuilder: (context, index) {
                    final favorito = _favoritos[index];
                    final filme = FilmeItem(
                      titulo: favorito.titulo,
                      imageUrl: favorito.imageUrl,
                    );

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            favorito.imageUrl,
                            width: 50,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                        ),
                        title: Text(
                          favorito.titulo,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          tooltip: 'Remover favorito',
                          onPressed: () => _removerFavorito(favorito.titulo),
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalhesFilmeScreen(filme: filme),
                            ),
                          );
                          await _carregarFavoritos();
                        },
                      ),
                    );
                  },
                ),
    );
  }
}