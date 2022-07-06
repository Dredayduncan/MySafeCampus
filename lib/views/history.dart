import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import 'package:my_safe_campus/widgets/custom_tab_label.dart';
import '../services/auth.dart';
import '../services/user_history.dart';
import '../widgets/custom_history_tile.dart';
import 'package:timeago/timeago.dart' as timeago;

class History extends StatefulWidget {
  final Auth auth;
  const History({Key? key, required this.auth}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  @override
  Widget build(BuildContext context) {
    UserHistory historyManager = UserHistory(userID: widget.auth.currentUser!.uid);
    return Scaffold(
        appBar: CustomAppBar(
          title: "History",
          auth: widget.auth,
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
                            label: "EMG. Alert"),
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
                        StreamBuilder<QuerySnapshot>(
                          stream: historyManager.getUserSMS(),
                          builder:
                              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            //Check if an error occurred
                            if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            }

                            // Check if the connection is still loading
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kDefaultBackground,
                                ),
                              );
                            }

                            // Check if there has been no conversation between them
                            if (snapshot.data?.size == 0) {
                              return const Center(child: Text("You have not used the emergency button before."));
                            }

                            // Get the chats between the user and the respondent
                            var doc = snapshot.data;

                            List sms = doc!.docs;

                            return ListView.builder(
                              itemCount: sms.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: CustomHistoryTile(
                                      title: "Button Was Pressed",
                                      alertStatus: sms[index]["status"],
                                      icon: Icons.sms,
                                      subtitle: sms[index]["status"] + " - " + timeago.format(sms[index]["timeSent"].toDate(), locale: 'en_short'),
                                    )
                                );
                              }
                            );
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: historyManager.getUserCalls(),
                          builder:
                              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            //Check if an error occurred
                            if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            }

                            // Check if the connection is still loading
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kDefaultBackground,
                                ),
                              );
                            }

                            // Check if there has been no conversation between them
                            if (snapshot.data?.size == 0) {
                              return const Center(child: Text("You have not made any calls."));
                            }

                            // Get the chats between the user and the respondent
                            var doc = snapshot.data;

                            List calls = doc!.docs;

                            return ListView.builder(
                                itemCount: calls.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: CustomHistoryTile(
                                        title: calls[index]['calleeName'],
                                        icon: Icons.call,
                                        callStatus: calls[index]["status"],
                                        subtitle: calls[index]["status"] + " - " +  timeago.format(calls[index]["timeCalled"].toDate(), locale: 'en_short'),
                                      )
                                  );
                                }
                            );
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: historyManager.getUserReports(),
                          builder:
                              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            //Check if an error occurred
                            if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            }

                            // Check if the connection is still loading
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kDefaultBackground,
                                ),
                              );
                            }

                            // Check if there has been no conversation between them
                            if (snapshot.data?.size == 0) {
                              return const Center(child: Text("You have not made any reports."));
                            }

                            // Get the chats between the user and the respondent
                            var doc = snapshot.data;

                            List reports = doc!.docs;

                            return ListView.builder(
                                itemCount: reports.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return reports[index]['status'] != "Cancelled"
                                    ? Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: CustomHistoryTile(
                                        title: reports[index]['formDetails']['offenceType'],
                                        icon: Icons.insert_drive_file_sharp,
                                        reportStatus: reports[index]["status"],
                                        subtitle: reports[index]["status"] + " - " + timeago.format(reports[index]["timeReported"].toDate(), locale: 'en_short'),
                                      )
                                    )
                                    : const SizedBox.shrink();
                                }
                            );
                          },
                        ),
                      ]
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
