import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../model/onboarding_model.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController _controller;

  int currentIndex = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: contents.length,
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      itemBuilder: (_, i) {
        return Scaffold(
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: kDefaultBackground,
            elevation: 0,
          ),
          backgroundColor: kDefaultBackground,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: Image(image: AssetImage(contents[i].image)),
                ),
                const Spacer(),
                Text(
                  contents[i].title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: kWhiteTextColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  contents[i].content,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: inactiveColor,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn,
                        );
                      },
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          color: kWhiteTextColor,
                        ),
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                      child: Text(
                        currentIndex == 0 ? '' : 'Previous',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: kWhiteTextColor,
                        ),
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: 3,
                      position: currentIndex.toDouble(),
                      decorator: DotsDecorator(
                        size: const Size.square(8.0),
                        color: inactiveColor,
                        spacing: const EdgeInsets.all(3),
                        sizes: const [
                          Size(8, 8),
                          Size(8, 8),
                          Size(8, 8),
                        ],
                        activeSize: const Size(50.0, 8.0),
                        activeColor: Colors.white,
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (currentIndex == contents.length - 1) {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamedAndRemoveUntil(
                                  '/login', (route) => false);
                        }
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn,
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerRight,
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: kWhiteTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 40))
              ],
            ),
          ),
        );
      },
    );
  }
}
