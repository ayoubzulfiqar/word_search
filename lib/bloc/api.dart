import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  List<String>? _words;
  Api();

// Step - 3

  Future<List<String>> search(String searchTerm) async {
    final term = searchTerm.trim().toLowerCase();
    final cachedResult = _extractWordsUsingSearchTerm(searchTerm);
    if (cachedResult != null) {
      return cachedResult;
    }

    // api calling
    final words = await _getData(
        "https://dl.dropboxusercontent.com/s/s4xik49426frdl4/words.json?dl=0");

    _words = words;

    return _extractWordsUsingSearchTerm(term) ?? [];
  }

// Step - 2

  List<String>? _extractWordsUsingSearchTerm(String word) {
    final cachedWords = _words;
    if (cachedWords != null) {
      List<String> result = [];
      for (final worded in cachedWords) {
        if (worded.contains(word.trim().toLowerCase())) {
          result.add(worded);
        }
      }
      return result;
    } else {
      return null;
    }
  }

// Step - 1
  // Future<List<dynamic>> _getData(String url) => HttpClient()
  //     .getUrl(Uri.parse(url))
  //     .then((request) => request.close())
  //     .then((response) => response.transform(utf8.decoder).join())
  //     .then((jsonString) => json.decode(jsonString) as List<dynamic>);

  Future<List<String>?> _getData(String url) async {
    final response = await http.Client().get(Uri.parse(url));
    final parsed = jsonDecode(response.body)['names'];
    List<String>? names = parsed != null ? List.from(parsed) : null;

    return names;
  }
}

// work only on String not list
extension TrimmedCaseInsensitiveContain on String {
  bool trimmedContains(String other) => trim().toLowerCase().contains(
        other.trim().toLowerCase(),
      );
}
