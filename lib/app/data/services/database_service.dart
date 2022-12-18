import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/place_model.dart';

class DatabaseService {
  CollectionReference places = FirebaseFirestore.instance.collection('places');

  Future<DocumentReference> addPlace(PlaceModel model) async {
    try {
      Map<String, Object?> json = model.toJson();
      json['createdAt'] = FieldValue.serverTimestamp();
      return await places.add(json);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> removePlace(PlaceModel model) async {
    try {
      await places.doc(model.id).delete();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updatePlace(PlaceModel model) async {
    try {
      await places.doc(model.id).update(model.toJson());
    } catch (e) {
      throw e.toString();
    }
  }
}
