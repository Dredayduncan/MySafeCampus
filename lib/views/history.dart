import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import 'package:my_safe_campus/widgets/custom_tab_label.dart';

import '../services/auth.dart';
import '../widgets/custom_history_tile.dart';
import '../widgets/custom_list_tile.dart';

class History extends StatefulWidget {
  final Auth auth;
  const History({Key? key, required this.auth}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List tabBars = [const Text("SMS"), const Text("Calls"), const Text("Reports")];

  List contacts = [
    {"label": "FR", "title": "First Respondent Team", "subtitle": "0322043112"},
    {"label": "FR", "title": "First Respondent Team", "subtitle": "0322043112"},
    {"label": "FR", "title": "First Respondent Team", "subtitle": "0322043112"},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: const CustomAppBar(
            title: "History",
          ),
          body: DefaultTabController(
            length: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Color(0xFF1E1E1E),
                    labelStyle: TextStyle(fontFamily: 'Quattrocentro'),
                    indicator: BoxDecoration(
                      color: kDefaultBackground,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    indicatorWeight: 2,
                    indicatorPadding: EdgeInsets.only(top: 40),
                    tabs: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Tab(
                          child: CustomTabLabel(
                              label: "SMS"),
                        ),
                      ),
                      Tab(
                        child: CustomTabLabel(
                      label: "Calls"),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child:  Tab(
                          child: CustomTabLabel(
                              label: "Reports"),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                        children: [
                          ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: CustomHistoryTile(
                                    title: contacts[index]["title"],
                                    icon: Icons.sms,
                                    subtitle: contacts[index]["subtitle"],
                                  )
                              );
                            }
                          ),
                          ListView.builder(
                              itemCount: contacts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: CustomHistoryTile(
                                      title: contacts[index]["title"],
                                      icon: Icons.call,
                                      subtitle: contacts[index]["subtitle"],
                                    )
                                );
                              }
                          ),
                          ListView.builder(
                              itemCount: contacts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: CustomHistoryTile(
                                      title: contacts[index]["title"],
                                      icon: Icons.insert_drive_file_sharp,
                                      subtitle: contacts[index]["subtitle"],
                                    )
                                );
                              }
                          ),
                        ]
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
