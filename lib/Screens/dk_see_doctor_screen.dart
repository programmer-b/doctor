import 'dart:convert';

import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_lists.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Components/dk_button_component.dart';
import 'package:afyadaktari/Components/dk_text_field.dart';
import 'package:afyadaktari/Fragments/apps/dk_see_doctor_fragment.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
        backgroundColor: dkPrimaryColor,
      ),
      body: const DKSeeDoctorFragment(),
    );
  }
}
