import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/router/router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex = 0;
  final List<DailyHabitModel> _completedHabits = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppStyles.kAppPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Row(
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
                  'Monday, 6',
                  style: AppStyles.kTextLabelStyle1,
                ),
                ActionButton(
                  onTap: () {},
                  icon: Icons.calendar_month_outlined,
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              padding: const EdgeInsets.all(AppStyles.kAppPadding),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white54,
                      size: 13,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey.shade900,
                        child: Image.asset(
                          AssetPath.readingHabit,
                          height: 40,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: size.height * 0.005,
                        children: [
                          Text(
                            'Notification!',
                            style: AppStyles.kTextLabelStyle3,
                          ),
                          Text(
                            'Now is the time to read the book,\nyou can '
                            'change it in settings.',
                            style: AppStyles.kTextLabelStyle2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: weekdays.length,
                itemBuilder: (context, index) {
                  final item = weekdays[index];
                  return GestureDetector(
                    onTap: () {
                      _selectedIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      height: 90,
                      width: 65,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppStyles.kAppPadding,
                      ),
                      margin:
                          const EdgeInsets.only(right: AppStyles.kAppPadding),
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? AppColors.activeColor
                            : Colors.transparent,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            item.dayName,
                            style: AppStyles.kTextLabelStyle1.copyWith(
                              fontSize: 13,
                              color: _selectedIndex == index
                                  ? Colors.white54
                                  : AppColors.textGrey,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            item.dayNumber,
                            style: AppStyles.kTextLabelStyle1.copyWith(
                              color: _selectedIndex == index
                                  ? Colors.white
                                  : AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Monday habit',
                  style: AppStyles.kTextLabelStyle1.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'See all',
                  style: AppStyles.kTextLabelStyle1.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            AlignedGridView.count(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              shrinkWrap: true,
              itemCount: dailyHabits.length,
              itemBuilder: (context, index) {
                final item = dailyHabits[index];
                final isSelected = _completedHabits.contains(item);
                return Container(
                  height: 170,
                  width: 150,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            item.image,
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              switch (isSelected) {
                                case true:
                                  _completedHabits.remove(item);
                                case false:
                                  _completedHabits.add(item);
                              }

                              setState(() {});
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: isSelected
                                    ? Colors.deepOrange
                                    : AppColors.greyColor,
                                size: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        item.habit,
                        style: AppStyles.kTextLabelStyle3.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        item.goal,
                        style: AppStyles.kTextLabelStyle1.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
