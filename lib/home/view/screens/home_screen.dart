import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppStyles.kAppPadding),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  icon: Icons.border_all_outlined,
                ),
                Text(
                  'Monday, 6',
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 16,
                  ),
                ),
                ActionButton(
                  icon: Icons.calendar_month_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
