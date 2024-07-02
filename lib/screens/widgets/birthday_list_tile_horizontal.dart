import 'package:flutter/material.dart';

class BirthdayListTileHorizontal extends StatelessWidget {
  BirthdayListTileHorizontal(
      {super.key,
      required this.name,
      required this.imageURL,
      required this.date,
      required this.index});
  final String name;
  final String imageURL;
  final DateTime date;
  final int index;
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
  final List<Color> colors = [
    const Color(0xFFF9CBCF),
    const Color(0xFFEACBF9),
    const Color(0xFFCFCBF9),
    const Color(0xFFCBF9DA),
    const Color(0xFFF9EECB),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: colors[index],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            imageURL,
            height: 70,
            width: 70,
          ),
          Text(
            name,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cake),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${months[date.month - 1]}/${date.day}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {},
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            color: const Color.fromARGB(255, 240, 113, 123),
            child: Text(
              "Send wishes",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
