import 'package:birth_daily/screens/views/onboard/onboard_1.dart';
import 'package:birth_daily/screens/views/onboard/onboard_2.dart';
import 'package:birth_daily/screens/views/onboard/onboard_3.dart';
import 'package:birth_daily/screens/views/onboard/onboard_4.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardTour extends StatefulWidget {
  const OnboardTour({super.key});

  @override
  State<OnboardTour> createState() => _OnboardTourState();
}

class _OnboardTourState extends State<OnboardTour> {
  final PageController _controller = PageController();
  bool onLast = false;
  bool backButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                backButton = (value != 0);
                onLast = (value == 3);
              });
            },
            controller: _controller,
            children: const [
              OnboardScreen1(),
              OnboardScreen2(),
              OnboardScreen3(),
              OnboardScreen4(),
            ],
          ),
          Positioned(
              top: 30,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  _controller.jumpToPage(3);
                },
                child: const Row(
                  children: [Text("Skip"), Icon(Icons.skip_next)],
                ),
              )),
          Container(
              alignment: const Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  backButton
                      ? GestureDetector(
                          onTap: () {
                            _controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          child: const Text("Back"),
                        )
                      : const SizedBox(width: 30),
                  SmoothPageIndicator(
                      controller: _controller,
                      count: 4,
                      effect: const WormEffect(),
                      onDotClicked: (index) {}),
                  GestureDetector(
                    onTap: () {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: onLast ? const Text("Done") : const Text("Next"),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
