import 'package:flutter/material.dart';
import 'package:infinite_words/bloc/api.dart';
import 'package:infinite_words/bloc/search_bloc.dart';
import 'package:infinite_words/view/search_result_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SearchBloc _bloc;

  @override
  void initState() {
    _bloc = SearchBloc(api: Api());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: const Text('Search'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Write a word",
                    hintStyle: const TextStyle(
                      fontSize: 20,
                      // color: Colors.white,
                    )),
                onChanged: _bloc.search.add),
            const SizedBox(
              height: 10,
            ),
            SearchResultView(searchResults: _bloc.results)
          ],
        ),
      ),
    );
  }
}
