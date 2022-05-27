import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/auth.dart';
import '../widgets/custom_appbar.dart';

class Report extends StatefulWidget {
  final Auth auth;

  const Report({
    Key? key,
    required this.auth
  }) : super(key: key);

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
                  fontFamily: 'Poppins',
                  fontSize: kDefaultHeading,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit amet posuere feugiat lorem. Magna urna ut blandit adipiscing. Enim turpis vitae vel netus tincidunt massa pellentesque. Senectus sagittis pellentesque velit non egestas nulla eget consectetur. Quis amet est hendrerit ac commodo.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Quattrocentro',
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () async {
                  String link = "https://forms.office.com/pages/responsepage.aspx?id=9WHGbQzuDka9tANK6z82cP7VRB2ScsBFo2eGJV0nIx1UMkFPM0tDRjFKWkJBMjMxNEE1TDA0U0VNVy4u";
                  if (!await launchUrl(Uri.parse(link))){
                    return showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                        AlertDialog(
                          title: const Text('Error'),
                          content: const Text(
                              'Link could not be opened'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                    );
                  }
                },
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
