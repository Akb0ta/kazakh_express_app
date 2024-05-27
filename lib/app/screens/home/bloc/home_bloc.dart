import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    String selectedImage = '';
    int selectedIndex = -1;
    int selectedFare = -1;
    on<HomeEvent>((event, emit) {
      if (event is HomeLoad) {
        emit(HomeLoaded(
            selectedImage: selectedImage,
            selectedIndex: selectedIndex,
            selectedFare: selectedFare));
      }
      if (event is HomeChangeSelectedImage) {
        selectedImage = event.image;
        emit(HomeLoaded(
            selectedImage: selectedImage,
            selectedIndex: selectedIndex,
            selectedFare: selectedFare));
      }
      if (event is HomeChangeSelectedIndex) {
        selectedIndex = event.index;
        emit(HomeLoaded(
            selectedImage: selectedImage,
            selectedIndex: selectedIndex,
            selectedFare: selectedFare));
      }
      if (event is HomeChangeSelectedFare) {
        selectedFare = event.index;
        emit(HomeLoaded(
            selectedImage: selectedImage,
            selectedIndex: selectedIndex,
            selectedFare: selectedFare));
      }
    });
  }
}
