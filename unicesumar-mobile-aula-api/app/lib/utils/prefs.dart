import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const _keyTheme = 'theme_mode';
  static const _keyBusca = 'ultimo_termo_busca';
  static const _keyOrdenacao = 'ultimo_criterio_ordenacao';

  static Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyTheme, mode);
  }

  static Future<String> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyTheme) ?? 'dark';
  }

  static Future<void> saveBusca(String termo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyBusca, termo);
  }

  static Future<String> loadBusca() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyBusca) ?? '';
  }

  static Future<void> saveOrdenacao(String criterio) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyOrdenacao, criterio);
  }

  static Future<String> loadOrdenacao() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyOrdenacao) ?? 'az';
  }
}