import 'package:birth_daily/helpers/list_tile_imgs.dart';
import 'package:birth_daily/screens/views/search/search_table_delegate.dart';
import 'package:birth_daily/screens/widgets/birthdat_list_tile_vertical.dart';
import 'package:birth_daily/services/birthday_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final BirthdayService _birthdayService = BirthdayService();
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: _birthdayService.getBirthdays(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(snapshot.data![index]),
                    endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            icon: Icons.edit,
                            label: 'Edit',
                            backgroundColor: Colors.blue,
                          ),
                          SlidableAction(
                            onPressed: (context) {},
                            icon: Icons.delete,
                            label: 'Delete',
                            backgroundColor: Colors.red,
                          ),
                        ]),
                    child: BirthdatListTileVertical(
                        date: snapshot.data![index].dateTime.toDate(),
                        name: snapshot.data![index].name,
                        imageURL: imageURLs[index % imageURLs.length],
                        index: index),
                  );
                },
              );
            }
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Birthdays added please go add"),
              );
            }
            return const Center(
              child:
                  Text("Something went wrong check yuor internet connection"),
            );
          },
        ),
      ),
    );
  }
}
