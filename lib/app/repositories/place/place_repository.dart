import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travely_admin/app/data/models/place_model.dart';

import 'base_place_repository.dart';

class PlaceRepository extends BasePlaceRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Stream<List<PlaceModel>> getPlaces() {
    return _db
        .collection('places')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => PlaceModel.fromMap(doc.id, doc.data())).toList();
    });
  }
}
