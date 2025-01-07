import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/components/components.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/router/router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late bool _toggleVisibility = true;
  late bool _isConfirmPasswordVisible = false;
  bool _isStrong = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailAddressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Align(
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
                      .copyWith(color: AppColors.textGrey),
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
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
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
                SizedBox(
                  width: size.width,
                  child: BlockButtonWidget(
                    onPressed: !_isStrong
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {}
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Register',
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
                                  context, AppRouter.loginRoute);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
