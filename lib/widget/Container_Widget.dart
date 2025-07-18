import 'package:flutter/material.dart';
class ContainerWidget extends StatelessWidget {
  final Widget child;
  const ContainerWidget({super.key,required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
           decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(16)
      ),
            child: child,
    );
  }
}
