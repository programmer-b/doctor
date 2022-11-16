import 'package:flutter/material.dart';

import '../Models/dk_service_data_model.dart';
import 'dk_images.dart';

List<MLServicesData> mlServiceDataList() {
  List<MLServicesData> list = [];
  list.add(MLServicesData(
    title: 'Clinic Visit',
    icon: Icons.home_work_outlined,
    image: dkdashClinicVisit,
    // widget: MLBookAppointmentScreen(index: 0));
  ));
  list.add(MLServicesData(
    title: 'Home Visit',
    icon: Icons.home,
    image: dkdashHomeVisit,
    // widget: MLBookAppointmentScreen(index: 0)
  ));
  list.add(MLServicesData(
    title: 'Video Consult',
    icon: Icons.video_call,
    image: dkdashVideoCons,
    // widget: MLVideoConsultScreen()
  ));
  list.add(MLServicesData(
    title: 'Pharmacy',
    icon: Icons.local_hospital,
    image: dkdashPharmacy,
    // widget: MLOnlinePharmacyScreen()
  ));
  list.add(MLServicesData(
    title: 'Diseases',
    icon: Icons.health_and_safety,
    image: dkdashDisease,
    // widget: MLDiseaseScreen()
  ));
  list.add(MLServicesData(
    title: 'Covid-19',
    icon: Icons.supervised_user_circle_outlined,
    image: dkdashCovid,
    // widget: MLCovidScreen()
  ));
  return list;
}
