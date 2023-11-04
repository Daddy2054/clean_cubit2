// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:clean_cubit2/features/dashboard/presentation/ui/widget/bottom_navigation_widget.dart';

class DashboardScreen extends StatelessWidget {
  final Widget child;
  const DashboardScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
