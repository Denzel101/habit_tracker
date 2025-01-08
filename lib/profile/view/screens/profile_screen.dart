import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/components/components.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/helpers/helpers.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/profile/profile.dart';
import 'package:habit_tracker/router/router.dart';
import 'package:habit_tracker/utils/utils.dart';
import 'package:habit_tracker/versioning/build_version.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

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
            ValueListenableBuilder(
              valueListenable: Hive.box<dynamic>(
                HabitTrackerConfig.instance!.values.hiveBoxKey,
              ).listenable(),
              builder: (context, _, __) {
                final authData = locator<HiveService>().retrieveUserInfo();
                return Container(
                  width: size.width,
                  height: 80,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    tileColor: AppColors.secondaryActiveColor,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppColors.activeColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.black,
                      size: 28,
                    ),
                    title: Text(
                      authData?.username ?? '',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                    ),
                    subtitle: Text(
                      authData?.email ?? '',
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
                );
              },
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
            BlocConsumer<LogoutUserCubit, LogoutUserState>(
              listener: (context, state) {
                state.mapOrNull(
                  error: (result) {
                    NotificationHelper.showToast(
                      context: context,
                      title: result.error,
                    );
                  },
                  loaded: (result) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouter.loginRoute,
                      (route) => false,
                    );
                  },
                );
              },
              builder: (context, state) {
                return MenuOption(
                  onTap: () async =>
                      context.read<LogoutUserCubit>().logoutUser(),
                  leading: const SizedBox(
                    height: 24,
                    width: 24,
                    child: Icon(Icons.login_outlined),
                  ),
                  title: 'Log Out',
                  trailing: state.maybeWhen(
                    loading: () => const LoadingIndicator(
                      color: Colors.black,
                      size: 10,
                    ),
                    orElse: () => Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black.withValues(alpha: 0.9),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Version $packageVersion',
              style: AppStyles.kTextLabelStyle3.copyWith(
                color: Colors.black,
              ),
            ),
          ].animate(
            interval: const Duration(milliseconds: 50),
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
