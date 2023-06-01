// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class FavouriteMovieTv {
  final int? id;
  final String? title;
  final String? image;
  final bool isFavourite;

  FavouriteMovieTv({
    required this.id,
    required this.title,
    required this.image,
    required this.isFavourite,
  });

  @override
  List<Object?> get props => [id, image, title, isFavourite];

  FavouriteMovieTv copyWith({
    bool? isFavourite,
  }) {
    return FavouriteMovieTv(
      id: id,
      title: title,
      image: image,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
