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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _meshController = AnimatedMeshGradientController();
  late bool _toggleVisibility = true;
  late bool _isConfirmPasswordVisible = false;
  bool _isStrong = false;
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
    _confirmPasswordController.dispose();
    _usernameController.dispose();
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
                    "Let's register you",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  CustomTextField(
                    label: 'Username*',
                    hintText: 'Enter username',
                    keyBoard: TextInputType.name,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Add Username';
                      }
                      return null;
                    },
                    textEditingController: _usernameController,
                  ),
                  SizedBox(
                    height: size.height * 0.016,
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
                    keyBoard: TextInputType.visiblePassword,
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
                      } else if (!_isStrong) {
                        return 'Invalid Password';
                      }
                      return null;
                    },
                    textEditingController: _passwordController,
                  ),
                  SizedBox(
                    height: size.height * 0.016,
                  ),
                  CustomTextField(
                    label: 'Confirm Password*',
                    hintText: 'Enter password',
                    textEditingController: _confirmPasswordController,
                    keyBoard: TextInputType.visiblePassword,
                    obscure: _isConfirmPasswordVisible,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                      icon: _isConfirmPasswordVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Confirm password is empty';
                      } else if (value.trim() != _passwordController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _passwordController,
                    builder: (context, child) {
                      final password = _passwordController.text;

                      return PasswordStrengthChecker(
                        onStrengthChanged: ({required bool isStrong}) =>
                            setState(() => _isStrong = isStrong),
                        password: password,
                      );
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  BlocConsumer<RegisterUserCubit, RegisterUserState>(
                    listener: (context, state) {
                      state.mapOrNull(
                        error: (result) => NotificationHelper.showToast(
                          context: context,
                          title: result.error,
                        ),
                        loaded: (result) {
                          if (result.user.email != null) {
                            Navigator.pushNamed(
                              context,
                              AppRouter.loginRoute,
                            );
                            NotificationHelper.showToast(
                              context: context,
                              title: 'Account Created Successfully',
                              isError: false,
                            );
                            _usernameController.clear();
                            _emailAddressController.clear();
                            _passwordController.clear();
                            _confirmPasswordController.clear();
                          } else {
                            NotificationHelper.showToast(
                              context: context,
                              title: 'User Not Created',
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
                                await context
                                    .read<RegisterUserCubit>()
                                    .registerUser(
                                      email: _emailAddressController.text,
                                      password: _passwordController.text,
                                      username: _usernameController.text,
                                    );
                              }
                            },
                          ),
                          child: state.maybeWhen(
                            loading: LoadingIndicator.new,
                            orElse: () => Text(
                              'Register',
                              style: AppStyles.kTextLabelStyle3.copyWith(
                                color: context.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                              ),
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
                        text: 'Already have an account? ',
                        style: AppStyles.kTextLabelStyle2
                            .copyWith(color: AppColors.textGrey),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign In',
                            style: AppStyles.kTextLabelStyle3.copyWith(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.loginRoute,
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
