import 'package:astro_test/models/beverage_category.dart';
import 'package:astro_test/models/food_category.dart';
import 'package:astro_test/repository/fnb_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fnb_category_state.dart';

class FNBCategoryCubit extends Cubit<FNBCategoryState> {
  final FNBRepository fnbRepository;

  FNBCategoryCubit({required this.fnbRepository}) : super(FNBCategoryInitial());

  void fetchMealCategories() async {
    try {
      emit(FNBCategoryFetching());
      final FoodCategory foodCategoryItems = await fnbRepository.fetchMealCategory();
      emit(FNBCategoryFetched(categories: foodCategoryItems.categories, beveragecategories: const[]));
    } catch (error) {
      emit(FNBCategoryFailedFetch(message: error.toString()));
    }
  }

  void fetchBeverageCategories() async{
    try {
      emit(FNBCategoryFetching());
      final BeverageCategory beverageCategoryItems = await fnbRepository.fetchBeverageCategory();
      emit(FNBCategoryFetched(categories: const [], beveragecategories: beverageCategoryItems.drinks));
    } catch (error) {
      emit(FNBCategoryFailedFetch(message: error.toString()));
    }
  }

  FNBCategoryFetched get stateAsLoaded => state as FNBCategoryFetched;
}
