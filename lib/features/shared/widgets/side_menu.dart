import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lead_center/config/menu/menu_items.dart';
import 'package:lead_center/features/auth/presentation/providers/auth_provider.dart';
// import 'package:go_router/go_router.dart';
import 'package:lead_center/features/shared/shared.dart';

class SideMenu extends ConsumerStatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key, 
    required this.scaffoldKey
  });

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    //Obtener el estado del authProvider
    final authState = ref.watch(authProvider);

    return NavigationDrawer(
      elevation: 1,
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {

        setState(() {
          navDrawerIndex = value;
        });

        final menuItem = appMenuItems[value];
        context.push( menuItem.link );
        widget.scaffoldKey.currentState?.closeDrawer();

      },
      
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, hasNotch ? 0 : 20, 16, 10),
          child: ListTile(
            title: Text(  
              authState.user?.fullName ?? 'Usuario'
            ),
            subtitle: Text(
              authState.user?.email ?? 'Email'
            ),
            leading: const CircleAvatar(
              radius: 40,
              child: Icon(
                Icons.perm_identity,
              ),
            ),
          ),
        ),
        ...appMenuItems
          .sublist(0,3)
          .map((item) => NavigationDrawerDestination(
            icon: Icon( item.icon ), 
            label: Text( item.title ),
          ),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10), 
          child: Divider(),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 5, 16, 5),
          child: Text('Ajustes'),
        ),

        ...appMenuItems
          .sublist(3,5)
          .map((item) => NavigationDrawerDestination(
            icon: Icon( item.icon ), 
            label: Text( item.title ),
          ),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10), 
          child: Divider(),
        ),
        
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 5, 16, 5),
          child: Text('Reportes'),
        ),

        ...appMenuItems
          .sublist(5,6)
          .map((item) => NavigationDrawerDestination(
            icon: Icon( item.icon ), 
            label: Text( item.title ),
          ),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10), 
          child: Divider(),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 5, 16, 5),
          child: Text('Tema'),
        ),

        ...appMenuItems
          .sublist(6,7)
          .map((item) => NavigationDrawerDestination(
            icon: Icon( item.icon ), 
            label: Text( item.title ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomFilledButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
            text: 'Cerrar sesión'
          ),
        ),

      ]
    );
  }
}