import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/widgets/custom_button.dart';

import '../widgets/custom_appbar.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Issue Reporting",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 300,
                child: Image(
                  image:
                      AssetImage("assets/images/Recording a movie-amico.png"),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Fill the reporting form",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: kDefaultHeading,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit amet posuere feugiat lorem. Magna urna ut blandit adipiscing. Enim turpis vitae vel netus tincidunt massa pellentesque. Senectus sagittis pellentesque velit non egestas nulla eget consectetur. Quis amet est hendrerit ac commodo.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {},
                btnName: "Proceed to form",
                buttonIcon: CupertinoIcons.link,
              )
            ],
          ),
        ),
      ),
    );
  }
}
