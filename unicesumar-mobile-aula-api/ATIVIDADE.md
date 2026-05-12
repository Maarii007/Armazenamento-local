# movies

Projeto Flutter: versão evoluída do app de aula com integração de API real, Clean Architecture e Riverpod.

**Material de apoio**: [MOVIES_GUIA.md](../MOVIES_GUIA.md)

---

## Setup Inicial

### 1. Clonar e Dependências

```bash
git clone <url>
cd movies
flutter pub get
```

### 2. Configurar API (TheMovieDB)

1. Crie conta em https://www.themoviedb.org/settings/api
2. Gere chave API
3. Crie arquivo `.env` na raiz:
```
TMDB_KEY=sua_chave_aqui
```

---

## Executar o Projeto

### 1️⃣ Localmente (Web)

```bash
flutter run -d chrome
```

Teste a app: navegue pelas telas, clique em filmes, verifique se os dados carregam.

### 2️⃣ Emulador Android

**Abrir Android Studio e criar emulador:**
1. Faça a instalação e configuração do Android Studio
2. Android Studio → Device Manager → Create Device
3. Escolha um dispositivo
4. Inicie o emulador

**Rodar no emulador:**
```bash
flutter devices          # Confirme que emulador aparece
flutter run
```

### 3️⃣ Celular via USB (Desafio)

**No celular:**
1. Configurações → Sobre → Número da compilação (toque 7x)
2. Volte, procure "Opções do desenvolvedor"
3. Ative: Depuração USB
4. Conecte via USB

**No computador:**
```bash
flutter devices          # Confirme que celular aparece
flutter run
```


---

### 4️⃣ Ler o [MOVIES_GUIA.md](../MOVIES_GUIA.md) para entender as mudanças no projeto.
---

## Documentação

- [Flutter Docs](https://flutter.dev/docs)
- [TheMovieDB API](https://www.themoviedb.org/settings/api)
- [Android Debug Bridge](https://developer.android.com/studio/command-line/adb)

