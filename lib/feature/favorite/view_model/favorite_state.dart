part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {}

class FavoriteError extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}
