import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/services/user_history.dart';
import 'package:my_safe_campus/widgets/custom_button.dart';
import 'package:my_safe_campus/widgets/custom_textfield.dart';
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
  final TextEditingController perpetrator = TextEditingController();
  final TextEditingController perpetratorInfo = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController _ctrl5 = TextEditingController();
  final TextEditingController _ctrl6 = TextEditingController();

  bool? chkvalue = false;

  // Initial Selected Value
  String dropdownvalue = 'Harassment';

  // List of items in our dropdown menu
  var items = [
    'Harassment',
    'Assault',
    'Rape',
  ];

  @override
  Widget build(BuildContext context) {
    UserHistory historyManager = UserHistory(userID: widget.auth.currentUser!.uid);

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
                                '1. Please state the name of the perpetrator.',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomFormField(
                                controller: perpetrator,
                                hintText: 'hintText',
                                onChanged: (value) {},
                                validator: (value) {},
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                '2. More information about perpetrator? (Class, Major, Gender)',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomFormField(
                                controller: perpetratorInfo,
                                hintText: 'hintText',
                                onChanged: (value) {},
                                validator: (value) {},
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                '3. Please state the form of sexual misconduct',
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
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                '4. Where did the issue occur?',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomFormField(
                                controller: location,
                                hintText: 'hintText',
                                onChanged: (value) {},
                                validator: (value) {},
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                '5. Give a brief description of what happened.',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomFormField(
                                controller: description,
                                hintText: 'hintText',
                                onChanged: (value) {},
                                validator: (value) {},
                              ),
                              const SizedBox(
                                height: 30,
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
                                                  onPressed: () {
                                                    historyManager.updateCancelledReports();
                                                    Navigator.pop(
                                                        context, 'Cancel');
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Map<String, String> formDetails = {
                                                      "perpetrator": perpetrator.text,
                                                      "perpetratorInfo": perpetratorInfo.text,
                                                      "offenceType": dropdownvalue,
                                                      "location": location.text,
                                                      "description": description.text
                                                    };

                                                    historyManager.updateReports(formDetails: formDetails).then((value) {
                                                      if (value == true){
                                                        setState(() {
                                                          perpetrator.clear();
                                                          perpetratorInfo.clear();
                                                          location.clear();
                                                          description.clear();
                                                        });

                                                        // Remove the confirmation pop up
                                                        Navigator.pop(
                                                            context, 'Yes');

                                                        // display the feedback pop up
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) =>
                                                            AlertDialog(
                                                              title: const Text('Error'),
                                                              content: const Text(
                                                                  'Your report has been sent!'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(context, 'OK'),
                                                                  child: const Text('OK'),
                                                                ),
                                                              ],
                                                            )
                                                        );
                                                      }
                                                    });
                                                  },
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
