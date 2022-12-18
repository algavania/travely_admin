import '../../data/models/place_model.dart';

abstract class BasePlaceRepository {
  Stream<List<PlaceModel>> getPlaces();
}
