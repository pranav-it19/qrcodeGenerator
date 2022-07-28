import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator/styles/styles.dart';
import 'package:qr_code_generator/tabs/yesterday_logs.dart';
import 'package:qr_code_generator/widgets/styled_container_widget.dart';
import 'package:qr_code_generator/tabs/other_logs.dart';
import 'package:qr_code_generator/tabs/today_logs.dart';
import 'package:qr_code_generator/tabs/yesterday_logs.dart';

class PreviousLogs extends StatefulWidget {
  const PreviousLogs({Key? key}) : super(key: key);

  @override
  State<PreviousLogs> createState() => _PreviousLogsState();
}

class _PreviousLogsState extends State<PreviousLogs>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: StyledContainer(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              child: TabBar(
                controller: _controller,
                tabs: [
                  Tab(
                    text: 'Today',
                  ),
                  Tab(
                    text: 'Yesterday',
                  ),
                  Tab(
                    text: 'Other',
                  ),
                ],
              ),
            ),
            Container(
              height: Get.context!.height * 0.5,
              child: TabBarView(
                  controller: _controller,
                  children: [TodayLogs(), YesterDayLogs(), OtherLogs()]),
            ),
            ElevatedButton(
                style: buttonStyle,
                onPressed: () {},
                child: Text(
                  'SAVE',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
