import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_generator/authentication/firestore_functions.dart';
import 'package:qr_code_generator/widgets/log_container_widget.dart';

class TodayLogs extends StatefulWidget {
  const TodayLogs({Key? key}) : super(key: key);

  @override
  State<TodayLogs> createState() => _TodayLogsState();
}

class _TodayLogsState extends State<TodayLogs> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('saved_qr').snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            return ListView.builder(
                itemCount: snap.data!.docs.length,
                itemBuilder: (ctx, ind) {
                  DocumentSnapshot doc = snap.data!.docs[ind];
                  return LogContainer(
                    time: doc['time'],
                    ipaddress: doc['ip'],
                    location: doc['address'],
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
