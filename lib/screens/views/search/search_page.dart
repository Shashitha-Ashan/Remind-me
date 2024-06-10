import 'package:birth_daily/screens/views/search/search_table_delegate.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        actions: [
          IconButton(
              onPressed: () async {
                await showSearch(context: context, delegate: SearchTable());
              },
              icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}
