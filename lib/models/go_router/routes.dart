// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_flutter/models/app_state_manager.dart';

import 'package:new_flutter/models/grocery_manager.dart';
import 'package:new_flutter/models/profile_manager.dart';

import 'package:new_flutter/screens/screens.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

class MyRouter {
  final AppStateManager appStateManager;

  MyRouter(
    this.appStateManager,
  );

  late final router = GoRouter(
    refreshListenable: appStateManager,
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: initialize,
        path: '/',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        name: loginRouteName,
        path: '/loginScreen',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        name: onboarding,
        path: '/onboardingScreen',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
          name: 'homeroute',
          path: '/home/:tab',
          pageBuilder: (context, state) {
            final tab = state.params['tab'] ?? 'no value';
            return MaterialPage<void>(
              key: state.pageKey,
              child: HomeScreen(tab: tab),
            );
          },
          routes: [
            GoRoute(
              name: 'groceryitemadd',
              path: 'grocery-itemadd',
              builder: (context, state) {
                final additem =
                    Provider.of<GroceryManager>(context, listen: false).addItem;
                return GroceryItemScreen(
                    oncreate: additem, onUpdate: (item, index) {});
              },
            ),
            GoRoute(
                name: 'groceryitemupdate',
                path: 'groceryitemupdate/:id',
                builder: (context, state) {
                  final gmanager =
                      Provider.of<GroceryManager>(context, listen: false);

                  return GroceryItemScreen.page(
                    onCreate: (item) {},
                    onUpdate: (item, index) => gmanager.updateItem(item, index),
                    item: gmanager.selectedGroceryItem,
                    index: gmanager.selectedIndex,
                  );
                })
          ]),
      GoRoute(
          path: '/profilescreen',
          pageBuilder: (context, state) {
            final user = context.read<ProfileManager>().getUser;
            return MaterialPage<void>(
              key: state.pageKey,
              child: ProfileScreen(user: user),
            );
          }),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(state.error.toString()),
          ),
        )),
    redirect: (state) {
      final initialize = state.location == '/';
      final initialized = appStateManager.isInitialized;
      final loggingIn = state.location == '/loginScreen';
      final loggedIn = appStateManager.isLoggedIn;
      final onboarding = state.location == '/onboardingScreen';
      final onboarded = appStateManager.isOnboardingComplete;

      if (!initialize && !initialized) return '/';
      if (initialized && (!loggingIn && !loggedIn)) return '/loginScreen';
      if (loggingIn && loggedIn) return '/onboardingScreen';
      if (loggedIn && (!onboarding && !onboarded)) return '/onboardingScreen';
      if (onboarding && onboarded) {
        return '/home/explore';
      }
      return null;
    },
  );
}
