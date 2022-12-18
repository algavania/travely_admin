import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import 'app/common/app_theme_data.dart';
import 'app/common/color_values.dart';
import 'app/repositories/repositories.dart';
import 'app/routes/router.gr.dart';
import 'firebase_options.dart';

final appRouter = AppRouter();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static AppRouter getAppRouter(BuildContext context) {
    return appRouter;
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (_, __, ___) {
      return GlobalLoaderOverlay(
        useDefaultLoading: false,
        closeOnBackButton: true,
        overlayWidget: const Center(
            child: SpinKitChasingDots(
              color: ColorValues.primaryBlue,
              size: 50.0,
            )),
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => AuthRepository(),
            ),
            RepositoryProvider(
              create: (context) => PlaceRepository(),
            ),
          ],
          child: MaterialApp.router(
            theme: AppThemeData.getTheme(context),
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      );
    });
  }
}
