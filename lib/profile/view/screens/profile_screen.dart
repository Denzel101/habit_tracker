import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/profile/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            const TopInfoWidget(
              title: 'Profile',
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const CircleAvatar(
              backgroundImage: AssetImage(AssetPath.profileImage),
              radius: 60,
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              width: size.width,
              height: 80,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: AppColors.secondaryActiveColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: AppColors.activeColor),
              ),
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: ListTile(
                    leading: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.black,
                      size: 28,
                    ),
                    title: Text(
                      'Denzel Gatugu',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                    ),
                    subtitle: Text(
                      'denzelgatugu@gmail.com',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Colors.grey.shade900,
                                fontSize: 14,
                              ),
                    ),
                    trailing: const Icon(
                      Icons.edit,
                      color: AppColors.activeColor,
                    ),
                  ),
                ),
              ),
            ),
            MenuOption(
              onTap: () {},
              leading: const SizedBox(
                height: 24,
                width: 24,
                child: Icon(Icons.brightness_2_outlined),
              ),
              title: 'Dark Mode',
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.black.withValues(alpha: 0.9),
              ),
            ),
            MenuOption(
              onTap: () {},
              leading: const SizedBox(
                height: 24,
                width: 24,
                child: Icon(Icons.sync_alt_outlined),
              ),
              title: 'Sync Data',
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.black.withValues(alpha: 0.9),
              ),
            ),
            MenuOption(
              onTap: () {},
              leading: const SizedBox(
                height: 24,
                width: 24,
                child: Icon(Icons.login_outlined),
              ),
              title: 'Log Out',
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.black.withValues(alpha: 0.9),
              ),
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
