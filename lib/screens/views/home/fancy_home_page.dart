import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FancyHomePage extends StatefulWidget {
  const FancyHomePage({super.key});

  @override
  State<FancyHomePage> createState() => _FancyHomePageState();
}

class _FancyHomePageState extends State<FancyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('birthdays').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No birthdays found'));
        }

        final birthdays = snapshot.data!.docs;

        return CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("RemindMe"),
              floating: true,
              centerTitle: true,
              collapsedHeight: 120,
              pinned: true,
              shape: BeveledRectangleBorder(),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              delegate: SliverChildBuilderDelegate((context, index) {
                final birthday = birthdays[index];
                final name = birthday['name'];
                final date = (birthday['date'] as Timestamp).toDate();
                return Container(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      color: Colors.amber,
                      child: GridTile(
                        child: Icon(Icons.person),
                        header: Text(name),
                      ),
                    ),
                  ),
                );
              }, childCount: birthdays.length),
            ),
          ],
        );
      },
    );
  }
}
