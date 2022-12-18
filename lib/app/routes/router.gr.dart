// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/cupertino.dart' as _i4;
import 'package:flutter/material.dart' as _i3;

import '../data/models/place_model.dart' as _i5;
import '../ui/screens.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NavigationRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.NavigationPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PlaceFormRoute.name: (routeData) {
      final args = routeData.argsAs<PlaceFormRouteArgs>(
          orElse: () => const PlaceFormRouteArgs());
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.PlaceFormPage(
          key: args.key,
          placeModel: args.placeModel,
        ),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ProfilePage(),
      );
    },
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash',
          fullMatch: true,
        ),
        _i2.RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        _i2.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i2.RouteConfig(
          NavigationRoute.name,
          path: '/home',
          children: [
            _i2.RouteConfig(
              HomeRoute.name,
              path: '',
              parent: NavigationRoute.name,
            ),
            _i2.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: NavigationRoute.name,
            ),
          ],
        ),
        _i2.RouteConfig(
          PlaceFormRoute.name,
          path: '/form',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i2.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.NavigationPage]
class NavigationRoute extends _i2.PageRouteInfo<void> {
  const NavigationRoute({List<_i2.PageRouteInfo>? children})
      : super(
          NavigationRoute.name,
          path: '/home',
          initialChildren: children,
        );

  static const String name = 'NavigationRoute';
}

/// generated route for
/// [_i1.PlaceFormPage]
class PlaceFormRoute extends _i2.PageRouteInfo<PlaceFormRouteArgs> {
  PlaceFormRoute({
    _i4.Key? key,
    _i5.PlaceModel? placeModel,
  }) : super(
          PlaceFormRoute.name,
          path: '/form',
          args: PlaceFormRouteArgs(
            key: key,
            placeModel: placeModel,
          ),
        );

  static const String name = 'PlaceFormRoute';
}

class PlaceFormRouteArgs {
  const PlaceFormRouteArgs({
    this.key,
    this.placeModel,
  });

  final _i4.Key? key;

  final _i5.PlaceModel? placeModel;

  @override
  String toString() {
    return 'PlaceFormRouteArgs{key: $key, placeModel: $placeModel}';
  }
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.ProfilePage]
class ProfileRoute extends _i2.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: 'profile',
        );

  static const String name = 'ProfileRoute';
}
