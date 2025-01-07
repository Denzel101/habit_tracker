import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: AppStyles.kAppPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: AppStyles.kTextLabelStyle1.copyWith(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: size.height * 0.008,
              ),
              Text(
                'Login to your account',
                style: AppStyles.kTextLabelStyle2.copyWith(
                  color: AppColors.textGrey,
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
