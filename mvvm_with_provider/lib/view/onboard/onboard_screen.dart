import 'package:flutter/material.dart';
import 'package:mvvm_with_provider/res/components/text_sub_widget.dart';
import 'package:mvvm_with_provider/res/components/title_text_widget.dart';
import 'package:mvvm_with_provider/utils/routes/routes_name.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              'assets/onboard.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          _onboardBody(
            height,
            width,
            context,
          ),
        ],
      ),
    );
  }

  Widget _onboardBody(double height, double width, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const TitleWidget(titleText: "Welcome to Mova"),
        SizedBox(
          height: height * .02,
        ),
        const TextSubWidget(
            text:
                "The best movie streaming app of the century\n to make your days great!"),
        SizedBox(
          height: height * .02,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(RoutesName.home);
          },
          child: SizedBox(
            width: width * .4,
            height: height * .065,
            child: const Center(
              child: Text("Get Started"),
            ),
          ),
        ),
        SizedBox(
          height: height * .02,
        ),
      ],
    );
  }
}
