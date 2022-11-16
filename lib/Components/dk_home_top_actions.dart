import 'package:afyadaktari/Utils/dk_toast.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DKHomeTopActions extends StatelessWidget {
  const DKHomeTopActions({super.key});

  @override
  Widget build(BuildContext context) {
    int counter = 2;
    return Row(
      children: [
        const Icon(Icons.search, color: white, size: 24),
        10.width,
        Stack(
          children: [
            const Icon(Icons.shopping_bag_outlined, color: white, size: 24),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: Colors.red),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                child: Text(
                  counter.toString(),
                  style: boldTextStyle(size: 8, color: white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ).onTap(() {
          DKToast.toastTop("Cart pressed");
        }),
      ],
    );
  }
}
