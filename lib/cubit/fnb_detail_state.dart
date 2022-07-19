part of 'fnb_detail_cubit.dart';

@immutable
abstract class FNBDetailState {}

class FnbDetailInitial extends FNBDetailState {}

class FnbDetailFetching extends FNBDetailState {}

class FNBDetailFetched extends FNBDetailState {
  final MealDetail mealDetail;
  final DrinkDetail drinkDetail;

  FNBDetailFetched({required this.mealDetail, required this.drinkDetail});
  
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class FNBDetailFailedFetch extends FNBDetailState {

  final String message;

  FNBDetailFailedFetch({required this.message});

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}