part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeLoad extends HomeEvent {
  String companyId;
  HomeLoad({required this.companyId});
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
