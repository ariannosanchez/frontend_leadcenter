import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lead_center/config/router/app_router_notifier.dart';
import 'package:lead_center/features/auth/auth.dart';
import 'package:lead_center/features/auth/presentation/providers/auth_provider.dart';
import 'package:lead_center/features/leads/leads.dart';
import 'package:lead_center/features/stage_categories/presentation/screens/screens.dart';
import 'package:lead_center/features/stages/presentation/screens/screens.dart';
import 'package:lead_center/features/tag_categories/presentation/screens/screens.dart';
import 'package:lead_center/features/tags/presentation/screens/screens.dart';

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
        path: '/stage_categories',
        builder: (context, state) => const StageCategoriesScreen(),
      ),
      
      ///* TagCategory
      GoRoute(
        path: '/tag_categories',
        builder: (context, state) => const TagCategoriesScreen(),
      ),
      GoRoute(
        path: '/tag_category/:id',
        builder: (context, state) => TagCategoryScreen(
          tagCategoryId: int.parse(state.params['id'] ?? '0'),
        ),
      ),

      ///* Tag
      GoRoute(
        path: '/tags',
        builder: (context, state) => const TagsScreen(),
      ),
      
      GoRoute(
        path: '/tags/:id',
        builder: (context, state) => TagScreen(
          tagId: int.parse(state.params['id'] ?? '0'),
        ),
      ),

      ///* State
      GoRoute(
        path: '/stages',
        builder: (context, state) => const StagesScreen(),
      ),

      GoRoute(
        path: '/stages/:id',
        builder: (context, state) => StageScreen(
          stageId: int.parse(state.params['id'] ?? '0'),
        ),
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
