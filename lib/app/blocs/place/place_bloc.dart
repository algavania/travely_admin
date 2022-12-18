import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/place_model.dart';
import '../../repositories/repositories.dart';

part 'place_event.dart';

part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository _repository;
  StreamSubscription? _subscription;

  PlaceBloc({required PlaceRepository repository})
      : _repository = repository,
        super(PlaceLoading()) {
    on<LoadPlaces>(_onLoadPlaces);
    on<UpdatePlaces>(_onUpdatePlaces);
  }

  void _onUpdatePlaces(
      UpdatePlaces event,
      Emitter<PlaceState> emit,
      ) {
    emit(PlaceLoaded(places: event.places));
  }

  void _onLoadPlaces(
    LoadPlaces event,
    Emitter<PlaceState> emit,
  ) async {
    _subscription = _repository.getPlaces().listen(
      (places) {
        add(UpdatePlaces(places: places));
      },
    );
  }
}
