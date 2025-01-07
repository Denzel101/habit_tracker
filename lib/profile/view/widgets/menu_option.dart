import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';

class MenuOption extends StatelessWidget {
  const MenuOption({
    required this.onTap,
    required this.leading,
    required this.title,
    this.trailing,
    super.key,
  });

  final VoidCallback onTap;
  final Widget leading;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: const BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: ListTile(
              leading: leading,
              title: Text(
                title,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Colors.black,
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
