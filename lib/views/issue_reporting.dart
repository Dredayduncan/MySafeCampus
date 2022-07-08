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
  final TextEditingController other = TextEditingController();
  final TextEditingController _ctrl6 = TextEditingController();

  bool? chkvalue = false;

  // Initial Selected Value
  String dropdownvalue = 'Harassment';

  // List of items in our dropdown menu
  var items = [
    'Harassment',
    'Assault',
    'Rape',
    'Other',
  ];

  bool isOther = false;

  @override
  Widget build(BuildContext context) {
    UserHistory historyManager =
        UserHistory(userID: widget.auth.currentUser!.uid);

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

                                  if (newValue == 'Other') {
                                    setState(() {
                                      isOther = true;
                                    });
                                  } else {
                                    isOther = false;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              isOther
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '4. If other, kindly state what happened.',
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        CustomFormField(
                                          controller: other,
                                          hintText: 'hintText',
                                          onChanged: (value) {},
                                          validator: (value) {},
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(width: 0),
                              Text(
                                '${isOther ? '5.' : '4.'} Where did the issue occur?',
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
                              Text(
                                '${isOther ? '6.' : '5.'} Give a brief description of what happened.',
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
                                                    historyManager
                                                        .updateCancelledReports();
                                                    Navigator.pop(
                                                        context, 'Cancel');
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Map<String, String>
                                                        formDetails = {
                                                      "perpetrator":
                                                          perpetrator.text,
                                                      "perpetratorInfo":
                                                          perpetratorInfo.text,
                                                      "offenceType":
                                                        dropdownvalue == "Other"
                                                        ? other.text
                                                        : dropdownvalue,
                                                      "location": location.text,
                                                      "description":
                                                          description.text
                                                    };

                                                    historyManager
                                                        .updateReports(
                                                            formDetails:
                                                                formDetails)
                                                        .then((value) {
                                                      if (value == true) {
                                                        setState(() {
                                                          perpetrator.clear();
                                                          perpetratorInfo
                                                              .clear();
                                                          location.clear();
                                                          description.clear();
                                                        });

                                                        // Remove the confirmation pop up
                                                        Navigator.pop(
                                                            context, 'Yes');

                                                        // display the feedback pop up
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                                  title: const Text(
                                                                      'Error'),
                                                                  content:
                                                                      const Text(
                                                                          'Your report has been sent!'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          context,
                                                                          'OK'),
                                                                      child: const Text(
                                                                          'OK'),
                                                                    ),
                                                                  ],
                                                                ));
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
            
          ],
        ),
      ),
    );
  }

  void _onChanged(Object? value) {}
}
