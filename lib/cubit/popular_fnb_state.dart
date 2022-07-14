part of 'popular_fnb_cubit.dart';

@immutable
abstract class PopularFNBState {}

class PopularFNBInitial extends PopularFNBState {}

class PopularFNBFetching extends PopularFNBState {}

class PopularFNBFetched extends PopularFNBState {
  final PopularMeal popularMeal;
  PopularFNBFetched({required this.popularMeal});

  @override
  List<Object> get props => [popularMeal];

  @override
  bool get stringify => true;
}

class PopularFNBFailedFetch extends PopularFNBState {
  final String message;
  PopularFNBFailedFetch({required this.message});

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}
