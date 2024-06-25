import 'package:birth_daily/blocs/birthday/birthdays_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     context.read<BirthdaysBloc>().add(LoadEvent());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           stream:
//               FirebaseFirestore.instance.collection('birthdays').snapshots(),
//           builder: (context, snapshot) {
//             return CustomScrollView(
//               slivers: [
//                 SliverAppBar(
//                   pinned: true,
//                   floating: true,
//                   expandedHeight: 100,
//                   flexibleSpace: FlexibleSpaceBar(
//                     title: const Text("Home"),
//                     background: Image.asset(
//                       "assets/backgrounds/back.png",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   actions: [
//                     IconButton(
//                       onPressed: () {
//                         context.push("/settings");
//                       },
//                       icon: const Icon(Icons.settings),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         context.push("/search");
//                       },
//                       icon: const Icon(Icons.output),
//                     ),
//                   ],
//                 ),
//                 SliverToBoxAdapter(
//                   child: FirestoreListView(
//                     query: FirebaseFirestore.instance.collection('birthdays'),
//                     itemBuilder: (context, doc) {
//                       print(doc.data());
//                       return ListTile(
//                         title: Text(" ashan"),
//                       );
//                     },
//                   ),
//                 ),
//                 // SliverList(
//                 //   delegate: SliverChildBuilderDelegate(
//                 //     childCount: snapshot.data?.docs.length,
//                 //     (context, index) {
//                 //       print(snapshot.data?.docs[0]['name']);
//                 //       return ListTile(
//                 //         title: Text(snapshot.data?.docs[index]['name']),
//                 //       );
//                 //     },
//                 //   ),
//                 // ),
//                 SliverToBoxAdapter(
//                   child: BlocBuilder<BirthdaysBloc, BirthdaysState>(
//                     builder: (context, state) {
//                       if (state is LoadingState) {
//                         return Container(
//                             child: const CircularProgressIndicator());
//                       }
//                       if (state is SuccessLoadState) {
//                         return Text(
//                             "Name - ${state.birthdayModel.name} Date - ${state.birthdayModel.dateTime.day}");
//                       } else {
//                         return const Text("error occured");
//                       }
//                     },
//                   ),
//                 )
//               ],
//             );
//           }),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<BirthdaysBloc>().add(LoadBirthdaysEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirestoreListView(
        query: FirebaseFirestore.instance.collection('birthdays'),
        itemBuilder: (context, doc) {
          final birthday = doc.data();
          final date = birthday['date'].toDate();
          return ListTile(
            title: Text(birthday['name']),
            trailing: Text(date.day.toString()),
          );
        },
      ),
    );
  }
}
