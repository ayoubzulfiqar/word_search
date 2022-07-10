import 'package:flutter/material.dart';
import 'package:infinite_words/bloc/search_result.dart';
import 'package:infinite_words/widgets/grid_view_widget.dart';

class SearchResultView extends StatelessWidget {
  final Stream<SearchResult?> searchResults;
  const SearchResultView({
    Key? key,
    required this.searchResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: searchResults,
      builder: (
        BuildContext context,
        AsyncSnapshot snapshot,
      ) {
        if (snapshot.hasData) {
          final result = snapshot.data;
          if (result is SearchResultWithError) {
            return const Center(child: Text('Error'));
          } else if (result is SearchResultLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (result is SearchResultNoResult) {
            return const Center(child: Text('No Result Found'));
          } else if (result is SearchResultWithResult) {
            final results = result.result;
            return GridViewWidget(results: results);
          } else {
            return const Center(child: Text("Unknown State"));
          }
        } else {
          return const Center(
            child: Text(
              "Waiting.....",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }
      },
    );
  }
}
