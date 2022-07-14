part of 'fnb_category_cubit.dart';

@immutable
abstract class FNBCategoryState {}

class FNBCategoryInitial extends FNBCategoryState {}

class FNBCategoryFetching extends FNBCategoryState {}

class FNBCategoryFetched extends FNBCategoryState {
  final List<Category> categories;
  final List<Drink> beveragecategories;

  FNBCategoryFetched({ this.categories = const [], this.beveragecategories = const []});

  @override
  List<Object> get props => [categories, beveragecategories];

  @override
  bool get stringify => true;
}

class FNBCategoryFailedFetch extends FNBCategoryState {
  final String message;

  FNBCategoryFailedFetch({required this.message});

  @override
  List<Object> get props => [message];
  
  @override
  bool get stringify => true;
  
}
