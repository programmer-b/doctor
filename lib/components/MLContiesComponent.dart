import 'package:doctor/State/app_state.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:provider/provider.dart';

class CountiesComponent extends StatefulWidget {
  @override
  _CountiesComponentState createState() => _CountiesComponentState();
}

class _CountiesComponentState extends State<CountiesComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //  @override
    context
        .read<AppState>()
        .MLget(Uri.parse("https://counties-kenya.herokuapp.com/api/v1"));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppState>(context);

    return SafeArea(
      child: Scaffold(
          body: provider.successMap.length == 0
              ? Center(
                  child: Loader(),
                )
              : ListView.builder(
                  itemCount: provider.successMap.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => provider.countyResidenceUpdate(provider.successMap[index]['name']),
                      title: Text(provider.successMap[index]['name']),
                      trailing: Icon(Icons.chevron_right),
                    );
                  })),
    );
  }
}
