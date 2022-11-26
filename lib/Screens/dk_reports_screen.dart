import 'package:afyadaktari/Commons/dk_images.dart';
import 'package:flutter/material.dart';

class DKReportsScreeen extends StatefulWidget {
  const DKReportsScreeen({super.key});

  @override
  State<DKReportsScreeen> createState() => _DKReportsScreeenState();
}

class _DKReportsScreeenState extends State<DKReportsScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(dkMedicalReport),
      ),
    );
  }
}
