import 'package:flutter/material.dart';

class BirthdatListTileVertical extends StatelessWidget {
  BirthdatListTileVertical(
      {super.key,
      required this.date,
      required this.name,
      required this.imageURL});

  final String name;
  final String imageURL;
  final DateTime date;
  final List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 120,
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(78, 226, 128, 139),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        children: [
          Image.asset(
            imageURL,
            height: 100,
            width: 100,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 26, color: const Color(0xFFE85566)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cake, color: Color(0xFFE85566)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${months[date.month - 1]}/${date.day}",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
