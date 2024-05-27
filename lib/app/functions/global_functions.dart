import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class GlobalFunctions {
  Future<String> uploadImageToImgBB(BuildContext context) async {
    final String apiKey =
        'eea35a1728dda256d2c376902d77ca9d'; // Replace with your ImgBB API key

    final picker = ImagePicker();
    PickedFile? pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      final Uri apiUrl =
          Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey');

      // Create multipart request for image upload
      var request = http.MultipartRequest('POST', apiUrl)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      // Send request and get response
      var response = await request.send();

      // Read response
      if (response.statusCode == 200) {
        final String responseData = await response.stream.bytesToString();
        final Map<String, dynamic> decodedResponse = json.decode(responseData);
        if (decodedResponse['data'] != null &&
            decodedResponse['data']['url'] != null) {
          return decodedResponse['data']['url'];
        } else {
          throw Exception("Failed to upload image to ImgBB.");
        }
      } else {
        throw Exception(
            "Failed to upload image to ImgBB. Status code: ${response.statusCode}");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
      return 'null';
    }
  }

  String getWeekNameFromString(String dateString) {
    // Parse the string to a DateTime object
    DateTime date = DateFormat('dd/MM/yyyy').parse(dateString);

    // Define a date format for getting the week name
    DateFormat dateFormat = DateFormat.EEEE('en_US');

    // Format the date to get the week name
    String weekName = dateFormat.format(date);

    // Return the week name
    return weekName;
  }

  int countTrueValues(List<dynamic> list) {
    int count = 0;

    for (bool value in list) {
      if (value == true) {
        count++;
      }
    }

    return count;
  }

  bool containsDate(var listOfLists, String date) {
    // Iterate through the list of lists
    for (var innerList in listOfLists) {
      print(innerList);

      if (innerList.containsValue(date)) {
        return true; // Return true if the date is found in any map
      }
    }
    return false; // Return false if the date is not found in any map
  }

  String shortWeekName(String weekName) {
    String res = '';
    if (weekName == 'Sunday') {
      res = 'Su';
    }
    if (weekName == 'Monday') {
      res = 'Mo';
    }
    if (weekName == 'Tuesday') {
      res = 'Tu';
    }
    if (weekName == 'Wednesday') {
      res = 'We';
    }
    if (weekName == 'Thursday') {
      res = 'Th';
    }
    if (weekName == 'Friday') {
      res = 'Fr';
    }
    if (weekName == 'Saturday') {
      res = 'Sa';
    }
    return res;
  }

  int getSeatIndex(String seat) {
    // Разделение строки на номер строки и букву
    int rowNumber = int.parse(seat.substring(0, seat.length - 1));
    int seatIndex = seat.codeUnitAt(seat.length - 1) - 'a'.codeUnitAt(0);

    // Вычисление индекса
    int index = (rowNumber - 1) * 4 + seatIndex;

    // Возвращаем индекс
    return index;
  }

  List<bool> createBoolList(List<int> indexes) {
    // Создаем список длиной 60 со всеми значениями false
    List<bool> boolList = List<bool>.filled(60, false, growable: false);

    // Устанавливаем значения true для указанных индексов
    indexes.forEach((index) {
      if (index >= 0 && index < 60) {
        boolList[index] = true;
      }
    });

    return boolList;
  }
}
