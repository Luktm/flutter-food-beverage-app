import 'package:astro_test/models/drinks.dart';
import 'package:astro_test/models/meals.dart';
import 'package:astro_test/repository/fnb_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fnb_detail_state.dart';

class FNBDetailCubit extends Cubit<FNBDetailState> {
  final FNBRepository fnbRepository;
  FNBDetailCubit({required this.fnbRepository}) : super(FnbDetailInitial());
  
  Future<void> fetchMealDetailById({ required String id }) async{
    try {
      emit(FnbDetailFetching());
      final Meals mealDetail = await fnbRepository.fetchMealDetailById(id: id);
      emit(FNBDetailFetched(mealDetail: mealDetail, drinkDetail: Drinks(drinks: [])));
    } catch(error) {
      emit(FNBDetailFailedFetch(message: error.toString()));
    }
  }

  Future<void> fetchDrinkDetailById({ required String id }) async{
    try {
      emit(FnbDetailFetching());
      final Drinks drinkDetail = await fnbRepository.fetchDrinkDetailById(id: id);
      emit(FNBDetailFetched(mealDetail: Meals(meals: []), drinkDetail: drinkDetail));
    } catch(error) {
      emit(FNBDetailFailedFetch(message: error.toString()));
    }
  }
}