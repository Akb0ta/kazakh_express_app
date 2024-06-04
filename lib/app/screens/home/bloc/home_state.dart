part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoaded extends HomeState {
  final String selectedImage;
  final int selectedIndex;
  final int selectedFare;
  final companyData;
  final passengers;
  HomeLoaded(
      {required this.selectedImage,
      required this.selectedIndex,
      required this.passengers,
      required this.companyData,
      required this.selectedFare});
}
