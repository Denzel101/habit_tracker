import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';

class MenuOption extends StatelessWidget {
  const MenuOption({
    this.onTap,
    required this.leading,
    required this.title,
    this.trailing,
    super.key,
  });

  final VoidCallback? onTap;
  final Widget leading;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: Center(
            child: ListTile(
              tileColor: context.isDarkMode
                  ? Colors.grey.shade800
                  : AppColors.greyColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              leading: leading,
              title: Text(
                title,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 15,
                    ),
              ),
              trailing: trailing,
            ),
          ),
        ),
      ),
    );
  }
}
