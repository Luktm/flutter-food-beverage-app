part of 'popular_fnb_cubit.dart';

@immutable
abstract class PopularFNBState {}

class PopularFNBInitial extends PopularFNBState {}

class PopularFNBFetching extends PopularFNBState {}

class PopularFNBFetched extends PopularFNBState {
  final List<Meal> popularMeals;
  final List<Drink> popularBeverages;
  PopularFNBFetched({required this.popularMeals, required this.popularBeverages});

  @override
  List<Object> get props => [popularMeals, popularBeverages];

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
