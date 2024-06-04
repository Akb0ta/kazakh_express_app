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
    var passengers = [];
    on<HomeEvent>((event, emit) async {
      if (event is HomeLoad) {
        selectedIndex = -1;
        selectedFare = -1;
        for (var i = 0; i < int.parse(event.passengetCount.toString()); i++) {
          passengers.add(-1);
        }
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
            passengers: passengers,
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
            passengers: passengers,
            selectedFare: selectedFare));
      }
      if (event is HomeChangeSelectedIndex) {
        print(passengers);
        selectedIndex = event.index;
        bool isCencelled = false;
        for (var i = 0; i < passengers.length; i++) {
          if (passengers[i] == event.index) {
            passengers[i] = -1;
            isCencelled = true;
          }
        }
        if (!isCencelled) {
          bool isChanged = false;
          for (var i = 0; i < passengers.length; i++) {
            if (!isChanged) {
              if (passengers[i] == -1) {
                isChanged = true;
                passengers[i] = selectedIndex;
              }
            }
          }
        }
        emit(HomeLoaded(
            passengers: passengers,
            selectedImage: selectedImage,
            companyData: companyData,
            selectedIndex: selectedIndex,
            selectedFare: selectedFare));
      }
      if (event is HomeChangeSelectedFare) {
        selectedFare = event.index;
        emit(HomeLoaded(
            selectedImage: selectedImage,
            passengers: passengers,
            companyData: companyData,
            selectedIndex: selectedIndex,
            selectedFare: selectedFare));
      }
    });
  }
}
