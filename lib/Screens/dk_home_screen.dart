import 'package:flutter/material.dart';

class DKHomeScreen extends StatefulWidget {
  const DKHomeScreen({super.key});

  @override
  State<DKHomeScreen> createState() => _DKHomeScreenState();
}

class _DKHomeScreenState extends State<DKHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Home page")), body: const Center(child: Text("Home Page")),);
  }
}
