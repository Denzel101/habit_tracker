import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex = 0;
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
                const ActionButton(
                  icon: Icons.border_all_outlined,
                ),
                Text(
                  'Monday, 6',
                  style: AppStyles.kTextLabelStyle1,
                ),
                const ActionButton(
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
                      size: 17,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey.shade900,
                        child: const Icon(
                          Icons.notifications,
                          size: 30,
                          color: Colors.orange,
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
                          const Text(
                            'Notification!',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
                            ? Colors.deepOrange
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
          ],
        ),
      ),
    );
  }
}
