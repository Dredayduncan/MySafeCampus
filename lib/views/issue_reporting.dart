import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/widgets/custom_button.dart';
import 'package:my_safe_campus/widgets/custom_textfield.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/auth.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_formField.dart';

class Report extends StatefulWidget {
  final Auth auth;
  const Report({Key? key, required this.auth}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final TextEditingController _ctrl1 = TextEditingController();
  final TextEditingController _ctrl2 = TextEditingController();
  final TextEditingController _ctrl3 = TextEditingController();
  final TextEditingController _ctrl4 = TextEditingController();
  final TextEditingController _ctrl5 = TextEditingController();
  final TextEditingController _ctrl6 = TextEditingController();

  bool? chkvalue = false;

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Issue Reporting",
        extraInfo: 'To report an issue kindly fill the form below',
        auth: widget.auth,
      ),
      body: SingleChildScrollView(
        // reverse: true,
        child: Column(
          children: [
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.only(left: 15, right: 20),
            //   color: kAccentColor,
            //   height: 30,
            //   child:
            // ),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            left: 15,
                            right: 15,
                            bottom: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                '1. Please state your full name in the field below.',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomFormField(
                                controller: _ctrl1,
                                hintText: 'hintText',
                                onChanged: (value) {},
                                validator: (value) {},
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                '2. Please state your full name in the field below.',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomFormField(
                                controller: _ctrl1,
                                hintText: 'hintText',
                                onChanged: (value) {},
                                validator: (value) {},
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                '3. Please state your full name in the field below.',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomFormField(
                                controller: _ctrl1,
                                hintText: 'hintText',
                                onChanged: (value) {},
                                validator: (value) {},
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                '4. Please state your full name in the field below.',
                              ),
                              DropdownButton(
                                // Initial Value
                                value: dropdownvalue,
                                isExpanded: true,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                child: CustomButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text('Error'),
                                              content: const Text(
                                                  'Are you sure you want to submit this form?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Yes'),
                                                  child: const Text('Yes'),
                                                ),
                                              ],
                                            ));
                                  },
                                  btnName: 'Submit Report',
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
            // const SizedBox(
            //   width: double.infinity,
            //   height: 300,
            //   child: Image(
            //     image:
            //         AssetImage("assets/images/Recording a movie-amico.png"),
            //   ),
            // ),
            // const SizedBox(height: 20),
            // const Text(
            //   "Fill the reporting form",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontFamily: 'Poppins',
            //     fontSize: kDefaultHeading,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 10),
            // const Text(
            //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit amet posuere feugiat lorem. Magna urna ut blandit adipiscing. Enim turpis vitae vel netus tincidunt massa pellentesque. Senectus sagittis pellentesque velit non egestas nulla eget consectetur. Quis amet est hendrerit ac commodo.",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontFamily: 'Quattrocentro',
            //   ),
            // ),
            // const SizedBox(height: 20),
            // CustomButton(
            //   onPressed: () async {
            //     String link =
            //         "https://forms.office.com/pages/responsepage.aspx?id=9WHGbQzuDka9tANK6z82cP7VRB2ScsBFo2eGJV0nIx1UMkFPM0tDRjFKWkJBMjMxNEE1TDA0U0VNVy4u";
            //     if (!await launchUrl(Uri.parse(link))) {
            //       return showDialog(
            //         context: context,
            //         builder: (BuildContext context) => AlertDialog(
            //           title: const Text('Error'),
            //           content: const Text('Link could not be opened'),
            //           actions: <Widget>[
            //             TextButton(
            //               onPressed: () => Navigator.pop(context, 'OK'),
            //               child: const Text('OK'),
            //             ),
            //           ],
            //         ),
            //       );
            //     }
            //   },
            //   btnName: "Proceed to form",
            //   buttonIcon: CupertinoIcons.link,
            // )
          ],
        ),
      ),
    );
  }

  void _onChanged(Object? value) {}
}
