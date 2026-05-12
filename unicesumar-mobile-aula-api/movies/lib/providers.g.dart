// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$movieAPIServiceHash() => r'db9ab9b85429b927cb42da2dd05e3ebc092e5107';

/// See also [movieAPIService].
@ProviderFor(movieAPIService)
final movieAPIServiceProvider = Provider<MovieAPIService>.internal(
  movieAPIService,
  name: r'movieAPIServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$movieAPIServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MovieAPIServiceRef = ProviderRef<MovieAPIService>;
String _$movieViewModelHash() => r'cf4c906b6e1c760bec249168a822ae91ddea5605';

/// See also [movieViewModel].
@ProviderFor(movieViewModel)
final movieViewModelProvider = FutureProvider<MovieViewModel>.internal(
  movieViewModel,
  name: r'movieViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$movieViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MovieViewModelRef = FutureProviderRef<MovieViewModel>;
String _$appRouterHash() => r'42599edccdcfb58d05fc5c5c1776f848db2a5b20';

/// See also [appRouter].
@ProviderFor(appRouter)
final appRouterProvider = Provider<AppRouter>.internal(
  appRouter,
  name: r'appRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppRouterRef = ProviderRef<AppRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
