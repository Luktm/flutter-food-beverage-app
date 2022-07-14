import 'package:astro_test/models/popular_meal.dart';
import 'package:astro_test/repository/meal_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'popular_fnb_state.dart';

class PopularFNBCubit extends Cubit<PopularFNBState> {
  final MealRepository mealRepository;
  PopularFNBCubit({required this.mealRepository}) : super(PopularFNBInitial());

  void fetchMealsByCategoryName({required name}) async {
    try {
      emit(PopularFNBFetching());
      final PopularMeal popularMealItems = await mealRepository.fetchMealByCategoryName(name: name);
      emit(PopularFNBFetched(popularMeal: popularMealItems));
    } catch(error) {
      emit(PopularFNBFailedFetch(message: error.toString()));
    }
  }
}
