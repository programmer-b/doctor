import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Commons/dk_colors.dart';
import '../../Commons/dk_lists.dart';
import '../../Commons/dk_strings.dart';
import '../../Components/dk_button_component.dart';
import '../../Components/dk_text_field.dart';

class DKSeeDoctorFragment extends StatefulWidget {
  const DKSeeDoctorFragment({super.key});

  @override
  State<DKSeeDoctorFragment> createState() => _DKSeeDoctorFragmentState();
}

class _DKSeeDoctorFragmentState extends State<DKSeeDoctorFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DKTextField(
              hint: dkSearchForDoctors,
              suffixIcon:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ),
            15.height,
            Column(
              children: doctors
                  .map((e) => Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38)),
                        margin: const EdgeInsets.all(5),
                        child: Wrap(
                          spacing: 15,
                          children: [
                            Row(
                              children: [
                                Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 70, maxHeight: 70),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(e["image"]))),
                                ),
                                5.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          e["name"],
                                          style: boldTextStyle(
                                              color: dkPrimaryColor, size: 14),
                                        ),
                                        5.width,
                                        Text(e["code"],
                                            style: boldTextStyle(
                                                color: dkPrimaryColor,
                                                size: 14)),
                                      ],
                                    ),
                                    4.height,
                                    Text(
                                      e["specialty"],
                                      style: primaryTextStyle(
                                          color: dkPrimaryColor, size: 14),
                                    ),
                                    6.height,
                                    Row(
                                      children: [
                                        Text(
                                          e["cost"],
                                          style: boldTextStyle(
                                              color: dkPrimaryColor, size: 16),
                                        ),
                                        5.width,
                                        Text(
                                            e["available"]
                                                ? "Available"
                                                : "Not Available",
                                            style: boldTextStyle(
                                                color: dkPrimaryColor,
                                                size: 16)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (!e["available"])
                              Container()
                            else
                              DKButtonComponent(
                                onTap: () {},
                                text: "See Now",
                                isMin: true,
                                gradient: dkSubmitButtonGradient,
                              ),
                            DKButtonComponent(
                              onTap: () {},
                              text: "Schedule",
                              isMin: e["available"],
                              gradient: dkSubmitButtonGradient,
                              height: 35,
                            )
                          ],
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
