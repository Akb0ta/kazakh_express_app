import 'package:bus_app/api/local_storage.dart';
import 'package:bus_app/app/screens/create/create_screen.dart';
import 'package:bus_app/app/screens/home/bloc/home_bloc.dart';
import 'package:bus_app/app/screens/login/login_screen.dart';
import 'package:bus_app/app/screens/navigator/bloc/main_navigator_bloc.dart';
import 'package:bus_app/app/screens/splash/splash_screen.dart';
import 'package:bus_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusApp extends StatelessWidget {
  const BusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainNavigatorBloc()..add(MainNavigatorLoad()),
        ),
        BlocProvider(
          create: (context) => HomeBloc()..add(HomeLoad()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bus App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
          primaryColor: AppColors.primaryColor,
          dividerColor: AppColors.primaryColor,
        ),
        home: MediaQuery(
          child: SplashScreen(),
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        ),
      ),
    );
  }
}
