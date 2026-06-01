import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/favoritos_screen.dart';
import 'data/database/app_database.dart';
import 'models/filme_item.dart';
import 'models/tema_item.dart';
import 'ui/theme/app_theme.dart';
import 'utils/prefs.dart';
import 'widgets/filmes_listview.dart';
import 'widgets/temas_gridview.dart';

const List<TemaItem> temas = <TemaItem>[
  TemaItem(nome: 'Ação',             imageUrl: 'https://picsum.photos/seed/acao/500/350',      cor: Color(0xFF264653)),
  TemaItem(nome: 'Comédia',          imageUrl: 'https://picsum.photos/seed/comedia/500/350',   cor: Color(0xFF2A9D8F)),
  TemaItem(nome: 'Drama',            imageUrl: 'https://picsum.photos/seed/drama/500/350',     cor: Color(0xFFE76F51)),
  TemaItem(nome: 'Ficção Científica',imageUrl: 'https://picsum.photos/seed/ficcao/500/350',    cor: Color(0xFF1D3557)),
  TemaItem(nome: 'Suspense',         imageUrl: 'https://picsum.photos/seed/suspense/500/350',  cor: Color(0xFF6A4C93)),
  TemaItem(nome: 'Animação',         imageUrl: 'https://picsum.photos/seed/animacao/500/350',  cor: Color(0xFFF4A261)),
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final results = await Future.wait([
    carregarFilmes(),
    Prefs.loadThemeMode(),
    Prefs.loadBusca(),
    Prefs.loadOrdenacao(),
  ]);

  final filmes        = results[0] as List<FilmeItem>;
  final savedTheme    = results[1] as String;
  final savedBusca    = results[2] as String;
  final savedOrdenacao= results[3] as String;
  final initialMode   = savedTheme == 'light' ? ThemeMode.light : ThemeMode.dark;

  runApp(
    MainApp(
    filmes: filmes,
    initialThemeMode: initialMode,
    initialBusca: savedBusca,
    initialOrdenacao: savedOrdenacao,
    )
  );
}

Future<List<FilmeItem>> carregarFilmes() async {
  final String jsonString =
      await rootBundle.loadString('assets/data/filmes.json');
  final List<dynamic> dados = jsonDecode(jsonString) as List<dynamic>;
  return dados
      .cast<Map<String, dynamic>>()
      .map(FilmeItem.fromJson)
      .toList(growable: false);
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
    required this.filmes,
    required this.initialThemeMode,
    required this.initialBusca,
    required this.initialOrdenacao,
  });

  final List<FilmeItem> filmes;
  final ThemeMode initialThemeMode;
  final String initialBusca;
  final String initialOrdenacao;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  void _toggleTheme() {
    final next =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setState(() => _themeMode = next);
    Prefs.saveThemeMode(next == ThemeMode.light ? 'light' : 'dark');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aula - Lista de Filmes',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      home: TelaPrincipalMovieApp(
        filmes: widget.filmes,
        temas: temas,
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
        initialBusca: widget.initialBusca,
        initialOrdenacao: widget.initialOrdenacao,
      ),
    );
  }
}

class TelaPrincipalMovieApp extends StatefulWidget {
  const TelaPrincipalMovieApp({
    super.key,
    required this.filmes,
    required this.temas,
    required this.isDark,
    required this.onToggleTheme,
    required this.initialBusca,
    required this.initialOrdenacao,
  });

  final List<FilmeItem> filmes;
  final List<TemaItem> temas;
  final bool isDark;
  final VoidCallback onToggleTheme;
  final String initialBusca;
  final String initialOrdenacao;

  @override
  State<TelaPrincipalMovieApp> createState() => _TelaPrincipalMovieAppState();
}

class _TelaPrincipalMovieAppState extends State<TelaPrincipalMovieApp> {
  late TextEditingController _buscaController;
  late String _ordenacao;
  late List<FilmeItem> _filmesFiltrados;

  @override
  void initState() {
    super.initState();
    _buscaController = TextEditingController(text: widget.initialBusca);
    _ordenacao = widget.initialOrdenacao;
    _aplicarFiltro(widget.initialBusca, widget.initialOrdenacao);
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  void _aplicarFiltro(String busca, String ordenacao) {
    var lista = widget.filmes.where((f) {
      return f.titulo.toLowerCase().contains(busca.toLowerCase());
    }).toList();

    if (ordenacao == 'az') {
      lista.sort((a, b) => a.titulo.compareTo(b.titulo));
    } else if (ordenacao == 'za') {
      lista.sort((a, b) => b.titulo.compareTo(a.titulo));
    }

    setState(() => _filmesFiltrados = lista);
  }

  void _onBuscaChanged(String valor) {
    Prefs.saveBusca(valor);
    _aplicarFiltro(valor, _ordenacao);
  }

  void _onOrdenacaoChanged(String? valor) {
    if (valor == null) return;
    setState(() => _ordenacao = valor);
    Prefs.saveOrdenacao(valor);
    _aplicarFiltro(_buscaController.text, valor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App - Lista de Filmes'),
        centerTitle: true,
        actions: [
          // Botão de favoritos
          IconButton(
            tooltip: 'Favoritos',
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritosScreen(),
                ),
              );
            },
          ),

          IconButton(
            tooltip: widget.isDark ? 'Tema claro' : 'Tema escuro',
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Temas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: TemasGridView(
                temas: widget.temas,
                onTap: (tema) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tema selecionado: ${tema.nome}')),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: TextField(
                controller: _buscaController,
                onChanged: _onBuscaChanged,
                decoration: InputDecoration(
                  hintText: 'Buscar filme...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _buscaController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _buscaController.clear();
                            _onBuscaChanged('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Row(
                children: [
                  const Text('Ordenar: '),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _ordenacao,
                    items: const [
                      DropdownMenuItem(value: 'recentes', child: Text('Mais recentes')),
                      DropdownMenuItem(value: 'az',       child: Text('A → Z')),
                      DropdownMenuItem(value: 'za',       child: Text('Z → A')),
                    ],
                    onChanged: _onOrdenacaoChanged,
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Text(
                'Filmes em Destaque',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 4,
              child: _filmesFiltrados.isEmpty
                  ? const Center(child: Text('Nenhum filme encontrado.'))
                  : FilmesListView(
                      filmes: _filmesFiltrados,
                      onTap: (filme) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetalhesFilmeScreen(filme: filme),
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

class DetalhesFilmeScreen extends StatefulWidget {
  final FilmeItem filme;

  const DetalhesFilmeScreen({super.key, required this.filme});

  @override
  State<DetalhesFilmeScreen> createState() => _DetalhesFilmeScreenState();
}

class _DetalhesFilmeScreenState extends State<DetalhesFilmeScreen> {
  final AppDatabase _db = AppDatabase();
  bool _isFavorito = false;

  @override
  void initState() {
    super.initState();
    _verificarFavorito();
  }

  Future<void> _verificarFavorito() async {
    final result = await _db.isFavorito(widget.filme.titulo);
    setState(() => _isFavorito = result);
  }

  Future<void> _toggleFavorito() async {
    if (_isFavorito) {
      await _db.removerFavorito(widget.filme.titulo);
    } else {
      await _db.adicionarFavorito(widget.filme.titulo, widget.filme.imageUrl);
    }

    final novoEstado = await _db.isFavorito(widget.filme.titulo);
    if (mounted) {
      setState(() => _isFavorito = novoEstado);
    }
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
        title: const Text('Detalhes do Filme'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            tooltip: _isFavorito ? 'Remover favorito' : 'Favoritar',
            icon: Icon(
              _isFavorito ? Icons.favorite : Icons.favorite_border,
              color: _isFavorito ? Colors.red : null,
            ),
            onPressed: _toggleFavorito,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 320,
                height: 480,
                child: Image.network(
                  widget.filme.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.filme.titulo,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Icon(
                _isFavorito ? Icons.favorite : Icons.favorite_border,
                color: _isFavorito ? Colors.red : Colors.grey,
                size: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}