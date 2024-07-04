import 'package:flutter/material.dart';

class BirthdayUserProfile extends StatelessWidget {
  const BirthdayUserProfile(
      {super.key, required this.name, required this.date});
  final String name;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name[0].toUpperCase() + name.substring(1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Image.asset(
                "assets/avatars/4.png",
                height: 100,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Details",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Name"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Birth date"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
