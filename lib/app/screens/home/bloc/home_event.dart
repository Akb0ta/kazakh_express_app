part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeLoad extends HomeEvent {
  String companyId;
  String passengetCount;
  HomeLoad({required this.companyId, required this.passengetCount});
}

class HomeChangeSelectedImage extends HomeEvent {
  String image;
  HomeChangeSelectedImage({required this.image});
}

class HomeChangeSelectedIndex extends HomeEvent {
  int index;
  HomeChangeSelectedIndex({required this.index});
}

class HomeChangeSelectedFare extends HomeEvent {
  int index;
  HomeChangeSelectedFare({required this.index});
}
