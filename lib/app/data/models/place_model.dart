import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
  final String id, imageUrl, name, location, description;
  final double rating;

  const PlaceModel(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.location,
      required this.rating,
      required this.description});

  factory PlaceModel.fromMap(String id, Map<dynamic, dynamic> json) {
    return PlaceModel(
      id: id,
      name: json['name'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      rating: json['rating'],
      description: json['description'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'location': location,
      'rating': rating,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp()
    };
  }

  @override
  List<Object?> get props => [id, imageUrl, name, location, rating, description];
}
