import 'package:astro_test/models/meal_detail.dart';
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
      final MealDetail mealDetail = await fnbRepository.fetchMealDetailById(id: id);
      emit(FNBDetailFetched(mealDetail: mealDetail));
    } catch(error) {
      emit(FNBDetailFailedFetch(message: error.toString()));
    }
  }
}