import 'package:birth_daily/helpers/list_tile_imgs.dart';
import 'package:birth_daily/models/birthday/birthday_model.dart';
import 'package:birth_daily/repositories/birthdays/birthday_repo.dart';
import 'package:birth_daily/screens/widgets/birthdat_list_tile_vertical.dart';
import 'package:birth_daily/screens/widgets/delete_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

class SearchTable extends SearchDelegate {
  final BirthdayRepo _birthdayService = BirthdayRepo();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<BirthdayModel>>(
      future: _birthdayService.loadBirthdays(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No birthdays found.'));
        }
        final searchResults = snapshot.data!
            .where(
                (item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 15,
          ),
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(searchResults[index]),
              endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await deleteBirthdayAlert(
                            context: context, docId: snapshot.data![index].id!);
                      },
                      icon: Icons.delete,
                      label: 'Delete',
                      backgroundColor: Colors.red,
                    ),
                  ]),
              child: BirthdatListTileVertical(
                  birthdayModel: snapshot.data![index], index: index),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<BirthdayModel>>(
      future: _birthdayService.loadBirthdays(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No suggestions.'));
        }
        final List<BirthdayModel> suggestionList = query.isEmpty
            ? snapshot.data!
                .map(
                  (e) => e,
                )
                .toList()
            : snapshot.data!
                .where((item) =>
                    item.name.toLowerCase().contains(query.toLowerCase()))
                .toList();

        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 15,
          ),
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(suggestionList[index]),
              endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await deleteBirthdayAlert(
                            context: context, docId: snapshot.data![index].id!);
                      },
                      icon: Icons.delete,
                      label: 'Delete',
                      backgroundColor: Colors.red,
                    ),
                  ]),
              child: BirthdatListTileVertical(
                  birthdayModel: snapshot.data![index], index: index),
            );
          },
        );
      },
    );
  }
}
