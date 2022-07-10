import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:infinite_words/bloc/api.dart';
import 'package:infinite_words/bloc/search_result.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class SearchBloc {
  final Sink<String> search;
  final Stream<SearchResult?> results;

  void dispose() {
    search.close();
  }

  factory SearchBloc({required Api api}) {
    final textChanges = BehaviorSubject<String>();

    final result = textChanges
        .distinct()
        .debounceTime(const Duration(milliseconds: 350))
        .switchMap<SearchResult?>((String searchTerm) {
      if (searchTerm.isEmpty) {
        return Stream<SearchResult?>.value(null);
      } else {
        return Rx.fromCallable(() => api.search(searchTerm))
            .delay(const Duration(seconds: 1))
            .map(
              (results) => results.isEmpty
                  ? const SearchResultNoResult()
                  : SearchResultWithResult(results),
            )
            .startWith(const SearchResultLoading())
            .onErrorReturnWith((error, _) => SearchResultWithError(error));
      }
    });

    return SearchBloc._(
      search: textChanges.sink,
      results: result,
    );
  }
  const SearchBloc._({
    required this.search,
    required this.results,
  });
}
