import 'package:bloc/bloc.dart';
import 'package:bus_app/app/screens/home/home_screen.dart';
import 'package:bus_app/app/screens/tickets/ticket_screen.dart';

import 'package:flutter/material.dart';

part 'main_navigator_event.dart';
part 'main_navigator_state.dart';

class MainNavigatorBloc extends Bloc<MainNavigatorEvent, MainNavigatorState> {
  MainNavigatorBloc() : super(MainNavigatorInitial()) {
    List screens = [
      HomeScreen(),
      TicketScreen(),
      Container(),
      Container(),
      // WorkersScreen(),
      // RevenueScreen(),
      // SettingsScreen(),
    ];
    int index = 0;
    on<MainNavigatorEvent>((event, emit) async {
      if (event is MainNavigatorLoad) {
        // final SharedPreferences prefs = await SharedPreferences.getInstance();

        // bool isLogged = await prefs.getBool('isLogged') ?? false;
        // if (isLogged) {
        // } else {}
        emit(MainNavigatorLoaded(index: index, screens: screens));
      }

      if (event is MainNavigatorChangePage) {
        // final SharedPreferences prefs = await SharedPreferences.getInstance();

        index = event.index;
        emit(MainNavigatorLoaded(index: index, screens: screens));
      }
      if (event is MainNavigatorClear) {
        emit(MainNavigatorInitial());
      }
    });
  }
}
