import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    String selectedImage = '';
    int selectedIndex = -1;
    int selectedFare = -1;
    var companyData;
    on<HomeEvent>((event, emit) async {
      if (event is HomeLoad) {
        selectedIndex = -1;
        selectedFare = -1;
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('companies')
            .doc(event.companyId)
            .get();
        if (snapshot.exists) {
          companyData = snapshot.data() as Map<String, dynamic>;
          selectedImage = companyData['images'][0];
        }
        emit(HomeLoaded(
            companyData: companyData,
            selectedImage: selectedImage,
            selectedIndex: selectedIndex,
            selectedFare: selectedFare));
      }
      if (event is HomeChangeSelectedImage) {
        selectedImage = event.image;
        emit(HomeLoaded(
            companyData: companyData,
            selectedImage: selectedImage,
            selectedIndex: selectedIndex,
            selectedFare: selectedFare));
      }
      if (event is HomeChangeSelectedIndex) {
        selectedIndex = event.index;
        emit(HomeLoaded(
            selectedImage: selectedImage,
            companyData: companyData,
            selectedIndex: selectedIndex,
            selectedFare: selectedFare));
      }
      if (event is HomeChangeSelectedFare) {
        selectedFare = event.index;
        emit(HomeLoaded(
            selectedImage: selectedImage,
            companyData: companyData,
            selectedIndex: selectedIndex,
            selectedFare: selectedFare));
      }
    });
  }
}
