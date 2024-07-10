import 'package:birth_daily/helpers/birthday_wishes_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BirthdayGiftPage extends StatelessWidget {
  const BirthdayGiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Birthday Wishes"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return _giftContainer(
                  message: birthdayWishes[index], context: context);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 20,
              );
            },
            itemCount: 5),
      ),
    );
  }

  Widget _giftContainer(
      {required String message, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       FontAwesomeIcons.shareNodes,
                  //       color: Colors.blue,
                  //     )),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  IconButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: message));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Copied to clipboard"),
                        duration: Duration(seconds: 2),
                      ));
                    },
                    icon: const Icon(
                      Icons.copy,
                      color: Colors.purple,
                    ),
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(FontAwesomeIcons.heart,
                  //       color: Color(0xFFE85566)),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
