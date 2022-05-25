import 'package:flutter/material.dart';

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
        child: Column(),
      ),
    );
  }
}
