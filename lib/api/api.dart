import 'dart:developer';

import 'package:bus_app/app/functions/global_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiClient {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create operation with custom ID
  Future<void> createWithId(
      String collection, String documentId, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(documentId).set(data);
  }

  // Create operation with auto-generated ID
  Future<String> create(String collection, Map<String, dynamic> data) async {
    DocumentReference docRef =
        await _firestore.collection(collection).add(data);
    String docId = docRef.id;
    await _firestore
        .collection(collection)
        .doc(docId)
        .update({'userId': docId});
    return docId;
  }

  // Read operation
  Future<Map<String, dynamic>?> get(
      String collection, String documentId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection(collection).doc(documentId).get();
    return snapshot.data() as Map<String, dynamic>?;
  }

  // Update operation
  Future<void> update(String collection, String documentId,
      Map<String, dynamic> newData) async {
    await _firestore.collection(collection).doc(documentId).update(newData);
  }

  // Delete operation
  Future<void> delete(String collection, String documentId) async {
    await _firestore.collection(collection).doc(documentId).delete();
  }

  // Check if field exists
  Future<String> fieldExists(
      String collection, String field, dynamic value) async {
    String userId = '';
    QuerySnapshot snapshot = await _firestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .get();
    if (snapshot.docs.isNotEmpty) {
      userId = snapshot.docs[0].id;
    }
    return userId;
  }

  Future<List<DocumentSnapshot>> getCompaniesByRoutesAndRoadDay(String aPoint,
      String bPoint, String fromDay, String toDay, int countPassager) async {
    String weekFromName = GlobalFunctions().getWeekNameFromString(fromDay);
    String roadFromDay = GlobalFunctions().shortWeekName(weekFromName);

    String weekToDay = GlobalFunctions().getWeekNameFromString(toDay);
    String roadToDay = GlobalFunctions().shortWeekName(weekToDay);
    var combinedDocs;
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('routes')
        .where('aPoint', isEqualTo: aPoint)
        .where('bPoint', isEqualTo: bPoint)
        .where('roadDay', isEqualTo: roadFromDay)
        .get();

    try {
      List<DocumentSnapshot> res = [];
      if (toDay == '') {
        combinedDocs = query.docs;
      } else {
        combinedDocs = query.docs;
        QuerySnapshot query2 = await FirebaseFirestore.instance
            .collection('routes')
            .where('aPoint', isEqualTo: bPoint)
            .where('bPoint', isEqualTo: aPoint)
            .where('roadDay', isEqualTo: roadToDay)
            .get();
        combinedDocs.addAll(query2.docs);
      }

      for (var doc in combinedDocs) {
        if (doc['seats'].length == 0) {
          res.add(doc);
        } else {
          bool isDataExist = doc['seats'].any((map) => map['date'] == fromDay);

          if (isDataExist) {
            for (var i = 0; i < doc['seats'].length; i++) {
              if (doc['seats'][i]['date'] == fromDay) {
                int availableSeatsCount =
                    GlobalFunctions().countTrueValues(doc['seats'][i]['seats']);
                if (availableSeatsCount >= countPassager) {
                  res.add(doc);
                }
              }
            }
          } else {
            res.add(doc);
          }
        }
      }
      return res;
    } catch (e) {
      log("!!! Error fetching companies: $e");
      return [];
    }
  }
}
