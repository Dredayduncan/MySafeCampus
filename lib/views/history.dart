import 'package:flutter/material.dart';
import 'package:my_safe_campus/constants.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List tabBars = [Text("SMS"), Text("Calls"), Text("Reports")];

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
                children: const [
                  TabBar(
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
                        child: Tab(
                          text: "SMS",
                        ),
                      ),
                      Tab(
                        text: "Calls",
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Tab(
                          text: "Reports",
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
