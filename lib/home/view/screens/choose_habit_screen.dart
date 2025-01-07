import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:habit_tracker/components/components.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';

class ChooseHabitScreen extends StatefulWidget {
  const ChooseHabitScreen({super.key});

  @override
  State<ChooseHabitScreen> createState() => _ChooseHabitScreenState();
}

class _ChooseHabitScreenState extends State<ChooseHabitScreen> {
  final List<ChooseHabitModel> _chosenHabits = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppStyles.kAppPadding),
        child: SizedBox(
          width: size.width,
          child: BlockButtonWidget(
            onPressed: _chosenHabits.isEmpty ? null : () {},
            child: Text(
              'Get Started!',
              style: AppStyles.kTextLabelStyle3,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppStyles.kAppPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Text(
              'Choose habit',
              style: AppStyles.kTextLabelStyle1.copyWith(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Choose your daily habits, you can choose\nmore than one',
              style: AppStyles.kTextLabelStyle2.copyWith(
                color: AppColors.textGrey,
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            AlignedGridView.count(
              padding: EdgeInsets.zero,
              itemCount: chooseHabits.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                final item = chooseHabits[index];
                final isSelected = _chosenHabits.contains(item);
                return GestureDetector(
                  onTap: () {
                    switch (isSelected) {
                      case true:
                        _chosenHabits.remove(item);
                      case false:
                        _chosenHabits.add(item);
                    }

                    setState(() {});
                  },
                  child: Container(
                    height: 110,
                    width: 150,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: isSelected
                          ? AppColors.secondaryActiveColor
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.activeColor
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          item.image,
                          height: 35,
                        ),
                        const Spacer(),
                        Text(
                          item.habit,
                          style: AppStyles.kTextLabelStyle1.copyWith(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
          ].animate(
            effects: [
              const FadeEffect(),
              const SlideEffect(),
            ],
          ),
        ),
      ),
    );
  }
}
