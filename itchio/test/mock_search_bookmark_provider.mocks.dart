// Mocks generated by Mockito 5.4.4 from annotations
// in itchio/test/mock_search_bookmark_provider.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i5;

import 'package:itchio/providers/search_bookmark_provider.dart' as _i3;
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

/// A class which mocks [SearchBookmarkProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchBookmarkProvider extends _i1.Mock
    implements _i3.SearchBookmarkProvider {
  MockSearchBookmarkProvider() {
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
  List<String> get searchBookmarks => (super.noSuchMethod(
        Invocation.getter(#searchBookmarks),
        returnValue: <String>[],
      ) as List<String>);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i4.Future<void> addSearchBookmark(
    String? tab,
    String? filters,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addSearchBookmark,
          [
            tab,
            filters,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> removeSearchBookmark(
    String? tab,
    String? filters,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeSearchBookmark,
          [
            tab,
            filters,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  bool isSearchBookmarked(
    String? tab,
    String? filters,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #isSearchBookmarked,
          [
            tab,
            filters,
          ],
        ),
        returnValue: false,
      ) as bool);

  @override
  void reloadBookMarkProvider() => super.noSuchMethod(
        Invocation.method(
          #reloadBookMarkProvider,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<List<String>> fetchBookmarks() => (super.noSuchMethod(
        Invocation.method(
          #fetchBookmarks,
          [],
        ),
        returnValue: _i4.Future<List<String>>.value(<String>[]),
      ) as _i4.Future<List<String>>);

  @override
  List<String> getBookmarksFromSnapshotValue(dynamic data) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBookmarksFromSnapshotValue,
          [data],
        ),
        returnValue: <String>[],
      ) as List<String>);

  @override
  void addListener(_i5.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i5.VoidCallback? listener) => super.noSuchMethod(
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
