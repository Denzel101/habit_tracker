import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.icon,
    super.key,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
