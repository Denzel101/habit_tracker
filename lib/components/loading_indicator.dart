import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 15,
        width: 15,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
