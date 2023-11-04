import 'package:clean_cubit2/features/dashboard/presentation/ui/widget/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [],
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
