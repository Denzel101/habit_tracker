import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';

class ChooseHabitScreen extends StatefulWidget {
  const ChooseHabitScreen({super.key});

  @override
  State<ChooseHabitScreen> createState() => _ChooseHabitScreenState();
}

class _ChooseHabitScreenState extends State<ChooseHabitScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.07,
          ),
          Text(
            'Choose habit',
            style: AppStyles.kTextLabelStyle1.copyWith(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            'Choose your daily habits, you can choose\nmore than one',
            style: AppStyles.kTextLabelStyle2.copyWith(
              color: AppColors.textGrey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
