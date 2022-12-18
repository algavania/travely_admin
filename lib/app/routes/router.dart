import 'package:auto_route/auto_route.dart';
import '../ui/screens.dart';

// watch for file changes which will rebuild the generated files:
// flutter packages pub run build_runner watch

// only generate files once and exit after use:
// flutter packages pub run build_runner build

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    CustomRoute(
        page: SplashPage,
        path: '/splash',
        initial: true,
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: LoginPage,
        path: '/login',
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
      page: NavigationPage,
      path: '/home',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      children: [
        AutoRoute(path: '', page: HomePage),
        AutoRoute(path: 'profile', page: ProfilePage),
      ],
    ),
    CustomRoute(
      page: PlaceFormPage,
      path: '/form',
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ],
)
class $AppRouter {}
