import 'package:bai_tap_trainee/ui/widgets/app_devider.dart';
import 'package:flutter/material.dart';
import 'package:bai_tap_trainee/common/app_dimens.dart';

class MenuHeaderWidget extends StatelessWidget {
  final String title;

  const MenuHeaderWidget({
    this.title = "",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(
          left: AppDimens.marginNormal, top: AppDimens.marginLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: theme.textTheme.headline6,
            ),
          ),
          const SizedBox(height: AppDimens.marginSmall),
          const AppDivider(),
        ],
      ),
    );
  }
}
