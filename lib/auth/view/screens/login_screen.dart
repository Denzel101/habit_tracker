import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/components/components.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/helpers/helpers.dart';
import 'package:habit_tracker/router/router.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailAddressController = TextEditingController(
    text: kDebugMode ? 'denzelgatugu@outlook.com' : '',
  );
  final _passwordController = TextEditingController();
  final _meshController = AnimatedMeshGradientController();
  late bool _toggleVisibility = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _meshController.start();
    super.initState();
  }

  @override
  void dispose() {
    _emailAddressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: AnimatedMeshGradient(
        colors: const [
          AppColors.activeColor,
          Color(0xFFFD3247),
          AppColors.secondaryActiveColor,
          Color(0xFFFFF5EB),
        ],
        options: AnimatedMeshGradientOptions(
          speed: 4,
          amplitude: 60,
        ),
        controller: _meshController,
        child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: AppStyles.kAppPadding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome!',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: size.height * 0.008,
                  ),
                  Text(
                    "Let's log you in",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  CustomTextField(
                    label: 'Email Address*',
                    hintText: 'Enter email address',
                    keyBoard: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      const pattern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      final regExp = RegExp(pattern);

                      if (value!.trim().isEmpty) {
                        return 'Add Email Address';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Invalid Email Address';
                      }
                      return null;
                    },
                    textEditingController: _emailAddressController,
                  ),
                  SizedBox(
                    height: size.height * 0.016,
                  ),
                  CustomTextField(
                    label: 'Password*',
                    hintText: 'Enter password',
                    obscure: _toggleVisibility,
                    keyBoard: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.done,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => _toggleVisibility = !_toggleVisibility);
                      },
                      icon: _toggleVisibility
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.visibility_outlined),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Add Password';
                      }
                      return null;
                    },
                    textEditingController: _passwordController,
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  BlocConsumer<LoginUserCubit, LoginUserState>(
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
                      return SizedBox(
                        width: size.width,
                        child: BlockButtonWidget(
                          onPressed: state.maybeWhen(
                            loading: () => null,
                            orElse: () => () async {
                              if (_formKey.currentState!.validate()) {
                                await context.read<LoginUserCubit>().loginUser(
                                      email: _emailAddressController.text,
                                      password: _passwordController.text,
                                    );
                              }
                            },
                          ),
                          child: state.maybeWhen(
                            loading: LoadingIndicator.new,
                            orElse: () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login',
                                  style: AppStyles.kTextLabelStyle3,
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 17,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.024,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: AppStyles.kTextLabelStyle2
                            .copyWith(color: AppColors.textGrey),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Create',
                            style: AppStyles.kTextLabelStyle3.copyWith(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.registerRoute,
                                );
                              },
                          ),
                        ],
                      ),
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
          ),
        ),
      ),
    );
  }
}
