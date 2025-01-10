import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/components/components.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/helpers/helpers.dart';
import 'package:habit_tracker/router/router.dart';

class GoogleSignInWidget extends StatelessWidget {
  const GoogleSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                color: AppColors.activeColor,
                width: double.infinity,
                height: 1,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text('Or'),
            ),
            Expanded(
              child: Container(
                color: AppColors.activeColor,
                width: double.infinity,
                height: 1,
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        BlocConsumer<GoogleSignInCubit, GoogleSignInState>(
          listener: (context, state) {
            state.mapOrNull(
              error: (result) => NotificationHelper.showToast(
                context: context,
                title: result.error,
              ),
              loaded: (result) {
                if (result.user != null) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouter.landingRoute,
                    (route) => false,
                  );
                } else {
                  NotificationHelper.showToast(
                    context: context,
                    title: 'User Not Found',
                  );
                }
              },
            );
          },
          builder: (context, state) {
            return BlockButtonWidget(
              color: AppColors.activeColor,
              onPressed: state.maybeWhen(
                loading: () => null,
                orElse: () => () async {
                  await context.read<GoogleSignInCubit>().signInWithGoogle();
                },
              ),
              child: state.maybeWhen(
                loading: LoadingIndicator.new,
                orElse: () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.google,
                      size: 20,
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      'Sign in With Google',
                      style: AppStyles.kTextLabelStyle3.copyWith(
                        color: context.isDarkMode ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
