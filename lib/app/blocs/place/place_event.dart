part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();
}

class LoadPlaces extends PlaceEvent {
  @override
  List<Object> get props => [];
}

class UpdatePlaces extends PlaceEvent {
  final List<PlaceModel> places;

  const UpdatePlaces({required this.places});

  @override
  List<Object> get props => [places];
}

