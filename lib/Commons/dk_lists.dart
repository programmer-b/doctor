import 'package:afyadaktari/Commons/dk_images.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Screens/dk_appointment_screen.dart';
import 'package:afyadaktari/Screens/dk_help_screen.dart';
import 'package:afyadaktari/Screens/dk_home_screen.dart';
import 'package:afyadaktari/Screens/dk_insuarance_screen.dart';
import 'package:afyadaktari/Screens/dk_invoice_screen.dart';
import 'package:afyadaktari/Screens/dk_order_screen.dart';
import 'package:afyadaktari/Screens/dk_reports_screen.dart';
import 'package:afyadaktari/Screens/dk_see_doctor_screen.dart';
import 'package:afyadaktari/Screens/dk_settings_screen.dart';
import 'package:afyadaktari/Screens/dk_subscription_screen.dart';
import 'package:flutter/material.dart';

const List<Map<String, dynamic>> dkCountiesList = [
  {"name": "Mombasa", "code": 1, "capital": "Mombasa City"},
  {"name": "Kwale", "code": 2, "capital": "Kwale"},
  {"name": "Kilifi", "code": 3, "capital": "Kilifi"},
  {"name": "Tana River", "code": 4, "capital": "Hola"},
  {"name": "Lamu", "code": 5, "capital": "Lamu"},
  {"name": "Taita-Taveta", "code": 6, "capital": "Voi"},
  {"name": "Garissa", "code": 7, "capital": "Garissa"},
  {"name": "Wajir", "code": 8, "capital": "Wajir"},
  {"name": "Mandera", "code": 9, "capital": "Mandera"},
  {"name": "Marsabit", "code": 10, "capital": "Marsabit"},
  {"name": "Isiolo", "code": 11, "capital": "Isiolo"},
  {"name": "Meru", "code": 12, "capital": "Meru"},
  {"name": "Tharaka-Nithi", "code": 13, "capital": "Chuka"},
  {"name": "Embu", "code": 14, "capital": "Embu"},
  {"name": "Kitui", "code": 15, "capital": "Kitui"},
  {"name": "Machakos", "code": 16, "capital": "Machakos"},
  {"name": "Makueni", "code": 17, "capital": "Wote"},
  {"name": "Nyandarua", "code": 18, "capital": "Ol Kalou"},
  {"name": "Nyeri", "code": 19, "capital": "Nyeri"},
  {"name": "Kirinyaga", "code": 20, "capital": "Kerugoya/Kutus"},
  {"name": "Murang'a", "code": 21, "capital": "Murang'a"},
  {"name": "Kiambu", "code": 22, "capital": "Kiambu"},
  {"name": "Turkana", "code": 23, "capital": "Lodwar"},
  {"name": "West Pokot", "code": 24, "capital": "Kapenguria"},
  {"name": "Samburu", "code": 25, "capital": "Maralal"},
  {"name": "Trans-Nzoia", "code": 26, "capital": "Kitale"},
  {"name": "Uasin Gishu", "code": 27, "capital": "Eldoret"},
  {"name": "Elgeyo-Marakwet", "code": 28, "capital": "Iten"},
  {"name": "Nandi", "code": 29, "capital": "Kapsabet"},
  {"name": "Baringo", "code": 30, "capital": "Kabarnet"},
  {"name": "Laikipia", "code": 31, "capital": "Rumuruti"},
  {"name": "Nakuru", "code": 32, "capital": "Nakuru"},
  {"name": "Narok", "code": 33, "capital": "Narok"},
  {"name": "Kajiado", "code": 34},
  {"name": "Kericho", "code": 35, "capital": "Kericho"},
  {"name": "Bomet", "code": 36, "capital": "Bomet"},
  {"name": "Kakamega", "code": 37, "capital": "Kakamega"},
  {"name": "Vihiga", "code": 38, "capital": "Vihiga"},
  {"name": "Bungoma", "code": 39, "capital": "Bungoma"},
  {"name": "Busia", "code": 40, "capital": "Busia"},
  {"name": "Siaya", "code": 41, "capital": "Siaya"},
  {"name": "Kisumu", "code": 42, "capital": "Kisumu"},
  {"name": "Homa Bay", "code": 43, "capital": "Homa Bay"},
  {"name": "Migori", "code": 44, "capital": "Migori"},
  {"name": "Kisii", "code": 45, "capital": "Kisii"},
  {"name": "Nyamira", "code": 46, "capital": "Nyamira"},
  {"name": "Nairobi", "code": 47, "capital": "Nairobi City"}
];

const Map<String, dynamic> homeApplications = {
  "apps": [
    {"name": "See a doctor", "image": dkSeeDoctor, "route": DKSeeDoctor()},
    {
      "name": "Medical reports",
      "image": dkMedicalReport,
      "route": DKReportsScreeen()
    },
    {
      "name": "Insuarance",
      "image": dkMedicalInsuarance,
      "route": DKInsuaranceScreen()
    },
    {
      "name": "Subscription",
      "image": dkMedicalSubscription,
      "route": DKSubscription()
    },
    {"name": "Order", "image": dkMedicalOrder, "route": DKOrderScreen()},
    {"name": "Help/FAQ", "image": dkHelp, "route": DKHelpScreen()}
  ]
};

const Map<String, dynamic> drawerApplications = {
  "apps": [
    {"name": "Home", "icon": Icons.home, "route": DKHomeScreen()},
    {
      "name": "Appointments",
      "icon": Icons.local_hospital,
      "route": DKAppointmentScreen()
    },
    {
      "name": "Invoice",
      "icon": Icons.medical_services,
      "route": DKInvoiceScreen()
    },
    {"name": "Settings", "icon": Icons.settings, "route": DKSettingsScreen()},
    {
      "name": dkLogOut,
      "icon": Icons.logout,
    }
  ]
};

const List<Map<String, dynamic>> doctors = [
  {
    "name": "D.r Kamau Wachira",
    "image": dkDoctor1Image,
    "code": "Ra008-5432q",
    "specialty": "General practioner",
    "available": true,
    "reference_id": 1,
    "cost": "Ksh 495"
  },
  {
    "name": "D.r Obilo Wenga",
    "image": dkDoctor2Image,
    "code": "Rgftr43-98",
    "specialty": "General practioner",
    "available": true,
    "reference_id": 2,
    "cost": "Ksh 3495"
  },
  {
    "name": "D.r Alice Momio",
    "image": dkDoctor3Image,
    "code": "Qwerqws2-12",
    "specialty": "Pharmaceutical practioner",
    "available": false,
    "reference_id": 3,
    "cost": "Ksh 995"
  },
  {
    "name": "D.r James Okoth",
    "image": dkDoctor4Image,
    "code": "Ra008-5432q",
    "specialty": "General practioner",
    "available": true,
    "reference_id": 4,
    "cost": "Ksh 695"
  },
  {
    "name": "D.r Lilian Njeru",
    "image": dkDoctor5Image,
    "code": "Ra008-5432q",
    "specialty": "General practioner",
    "available": true,
    "reference_id": 5,
    "cost": "Ksh 1195"
  },
  {
    "name": "D.r Mary Wangari",
    "image": dkDoctor6Image,
    "code": "Ra008-5432q",
    "specialty": "General practioner",
    "available": true,
    "reference_id": 6,
    "cost": "Ksh 1095"
  },
  {
    "name": "D.r Seth Adam Mwangi",
    "image": dkDoctor7Image,
    "code": "Ra008-5432q",
    "specialty": "General practioner",
    "available": true,
    "reference_id": 7,
    "cost": "Ksh 905"
  },
  {
    "name": "D.r Wawira Mercy",
    "image": dkDoctor8Image,
    "code": "Ra008-5432q",
    "specialty": "General practioner",
    "available": true,
    "reference_id": 8,
    "cost": "Ksh 705"
  },
  {
    "name": "D.r Abdalla Mohammed",
    "image": dkDoctor9Image,
    "code": "Ra008-5432q",
    "specialty": "General practioner",
    "available": true,
    "reference_id": 9,
    "cost": "Ksh 900"
  },
  {
    "name": "D.r Mackenzie Dong'o",
    "image": dkDoctor10Image,
    "code": "Ra008-5432q",
    "specialty": "General practioner",
    "available": false,
    "reference_id": 10,
    "cost": "Ksh 1495"
  }
];
