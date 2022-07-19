import 'package:astro_test/models/drinks_category.dart';
import 'package:astro_test/models/drink.dart';
import 'package:astro_test/models/drinks.dart';
import 'package:astro_test/models/meal.dart';
import 'package:astro_test/models/meals.dart';
import 'package:astro_test/repository/fnb_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'popular_fnb_state.dart';

class PopularFNBCubit extends Cubit<PopularFNBState> {
  final FNBRepository fnbRepository;
  PopularFNBCubit({required this.fnbRepository}) : super(PopularFNBInitial());

  void fetchMealsByCategoryName({required String name}) async {
    try {
      emit(PopularFNBFetching());
      final Meals popularMealItems = await fnbRepository.fetchMealByCategoryName(name: name);
      emit(PopularFNBFetched(popularMeals: popularMealItems.meals ?? const [], popularBeverages: const[]));
    } catch(error) {
      emit(PopularFNBFailedFetch(message: error.toString()));
    }
  }

  void fetchBeverageByCategoryName({required String name}) async{
    try {
      emit(PopularFNBFetching());
      final Drinks popularBeverageItems = await fnbRepository.fetchBeverageByCategoryName(name: name);
      emit(PopularFNBFetched(popularMeals: const[], popularBeverages: popularBeverageItems.drinks ?? []));
    } catch(error) {
      emit(PopularFNBFailedFetch(message: error.toString()));
    }
  }
}
