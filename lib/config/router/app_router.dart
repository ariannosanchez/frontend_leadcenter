import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lead_center/config/router/app_router_notifier.dart';
import 'package:lead_center/features/auth/auth.dart';
import 'package:lead_center/features/auth/presentation/providers/auth_provider.dart';
import 'package:lead_center/features/leads/leads.dart';
import 'package:lead_center/features/state_categories/state_categories.dart';
import 'package:lead_center/features/tag_categories/presentation/screens/tag_categories_screen.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      //* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Lead Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const LeadsScreen(),
      ),
      GoRoute(
        path: '/lead/:id',
        builder: (context, state) => LeadScreen(
          leadId: state.params['id'] ?? 'no-id',
        ),
      ),

      ///* StateCategory
      GoRoute(
        path: '/state_categories',
        builder: (context, state) => const StateCategoriesScreen(),
      ),
      
      ///* TagCategory
      GoRoute(
        path: '/tag_categories',
        builder: (context, state) => const TagCategoriesScreen(),
      ),
    ],

    redirect: (context, state) {
      final isGoingTo = state.subloc;
      final authStatus = goRouterNotifier.authStatus;

      if( isGoingTo == '/splash' && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' ) return null;

        return '/login';
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash' ) {
          return '/';
        }
      }

      return null;
    },
  );
});
