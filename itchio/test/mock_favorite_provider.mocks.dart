// Mocks generated by Mockito 5.4.4 from annotations
// in itchio/test/mock_favorite_provider.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:itchio/models/game.dart' as _i4;
import 'package:itchio/models/jam.dart' as _i5;
import 'package:itchio/providers/favorite_provider.dart' as _i3;
import 'package:logger/logger.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeLogger_0 extends _i1.SmartFake implements _i2.Logger {
  _FakeLogger_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FavoriteProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavoriteProvider extends _i1.Mock implements _i3.FavoriteProvider {
  MockFavoriteProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Logger get logger => (super.noSuchMethod(
        Invocation.getter(#logger),
        returnValue: _FakeLogger_0(
          this,
          Invocation.getter(#logger),
        ),
      ) as _i2.Logger);

  @override
  List<_i4.Game> get favoriteGames => (super.noSuchMethod(
        Invocation.getter(#favoriteGames),
        returnValue: <_i4.Game>[],
      ) as List<_i4.Game>);

  @override
  List<_i5.Jam> get favoriteJams => (super.noSuchMethod(
        Invocation.getter(#favoriteJams),
        returnValue: <_i5.Jam>[],
      ) as List<_i5.Jam>);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i6.Future<void> addFavoriteGame(_i4.Game? game) => (super.noSuchMethod(
        Invocation.method(
          #addFavoriteGame,
          [game],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> removeFavoriteGame(_i4.Game? game) => (super.noSuchMethod(
        Invocation.method(
          #removeFavoriteGame,
          [game],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> addFavoriteJam(_i5.Jam? jam) => (super.noSuchMethod(
        Invocation.method(
          #addFavoriteJam,
          [jam],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> removeFavoriteJam(_i5.Jam? jam) => (super.noSuchMethod(
        Invocation.method(
          #removeFavoriteJam,
          [jam],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  bool isFavoriteGame(_i4.Game? game) => (super.noSuchMethod(
        Invocation.method(
          #isFavoriteGame,
          [game],
        ),
        returnValue: false,
      ) as bool);

  @override
  bool isFavoriteJam(_i5.Jam? jam) => (super.noSuchMethod(
        Invocation.method(
          #isFavoriteJam,
          [jam],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i6.Future<List<_i4.Game>> fetchFavoriteGames() => (super.noSuchMethod(
        Invocation.method(
          #fetchFavoriteGames,
          [],
        ),
        returnValue: _i6.Future<List<_i4.Game>>.value(<_i4.Game>[]),
      ) as _i6.Future<List<_i4.Game>>);

  @override
  _i6.Future<List<_i5.Jam>> fetchFavoriteJams() => (super.noSuchMethod(
        Invocation.method(
          #fetchFavoriteJams,
          [],
        ),
        returnValue: _i6.Future<List<_i5.Jam>>.value(<_i5.Jam>[]),
      ) as _i6.Future<List<_i5.Jam>>);

  @override
  List<_i4.Game> getGamesFromSnapshotValue(dynamic data) => (super.noSuchMethod(
        Invocation.method(
          #getGamesFromSnapshotValue,
          [data],
        ),
        returnValue: <_i4.Game>[],
      ) as List<_i4.Game>);

  @override
  List<_i5.Jam> getJamsFromSnapshotValue(dynamic data) => (super.noSuchMethod(
        Invocation.method(
          #getJamsFromSnapshotValue,
          [data],
        ),
        returnValue: <_i5.Jam>[],
      ) as List<_i5.Jam>);

  @override
  bool checkTimestamp(int? timestamp) => (super.noSuchMethod(
        Invocation.method(
          #checkTimestamp,
          [timestamp],
        ),
        returnValue: false,
      ) as bool);

  @override
  void addListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
