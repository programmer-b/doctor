import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Components/dk_text_field.dart';
import 'package:flutter/material.dart';

class DKSeeDoctor extends StatefulWidget {
  const DKSeeDoctor({super.key});

  @override
  State<DKSeeDoctor> createState() => _DKSeeDoctorState();
}

class _DKSeeDoctorState extends State<DKSeeDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(dkAvailableDoctors),
      ),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: const [
            DKTextField(hint: dkSearchForDoctors),
          ],
        ),
      ),
    );
  }
}
