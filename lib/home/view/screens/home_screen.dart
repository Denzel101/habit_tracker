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
          ],
        ),
      ),
    );
  }
}
