import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {

  const CustomBottomNavigation({super.key});

  int getCurrentIndex( BuildContext context ) {
    final String location = GoRouterState.of(context).location;

    switch(location) {
      case '/':
        return 0;

      case '/funnel':
        return 1;

      default:
        return 0;
    }
  }


  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/funnel');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return NavigationBar(
      elevation: 0,
      indicatorColor: colors.inversePrimary,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: size.height * 0.1,
      selectedIndex: getCurrentIndex(context),
      onDestinationSelected: (value) => onItemTapped(context, value),
      destinations: const [
        NavigationDestination(
          icon: Icon( Icons.person_pin_circle_rounded ),
          label: 'Leads'
        ),
        NavigationDestination(
          icon: Icon( Icons.stacked_line_chart_outlined ),
          label: 'Embudo'
        )
      ]
    );
  }
}