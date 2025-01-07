import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/router/router.dart';

class TopInfoWidget extends StatelessWidget {
  const TopInfoWidget({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActionButton(
          onTap: () => Navigator.pushNamed(
            context,
            AppRouter.chooseHabitRoute,
          ),
          icon: Icons.dashboard_outlined,
        ),
        Text(
          title,
          style: AppStyles.kTextLabelStyle1,
        ),
        ActionButton(
          onTap: () {},
          icon: Icons.calendar_month_outlined,
        ),
      ],
    );
  }
}
