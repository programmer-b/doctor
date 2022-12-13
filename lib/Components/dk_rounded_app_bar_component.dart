import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RoundedAppBar({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: LayoutBuilder(builder: (context, constraint) {
        return Container(
          height: 260,
          width: context.width(),
          margin: const EdgeInsets.only(bottom: 16.0),

          child: child,
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(260.0);
}
