import 'package:astro_test/cubit/fnb_category_cubit.dart';
import 'package:astro_test/cubit/popular_fnb_cubit.dart';
import 'package:astro_test/repository/fnb_repository.dart';
import 'package:astro_test/screens/beverage_home_screen.dart';
import 'package:astro_test/screens/meal_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/main_menu_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final FNBRepository mealRepository  = FNBRepository();

  @override
  Widget build(BuildContext context) {

    FNBCategoryCubit mealGategoryCubit = FNBCategoryCubit(mealRepository: mealRepository);
    PopularFNBCubit popularMealCubit = PopularFNBCubit(fnbRepository: mealRepository);
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<FNBCategoryCubit>(create: (ctx) => mealGategoryCubit),
        BlocProvider<PopularFNBCubit>(create: (ctx) => popularMealCubit),
      ],
      child: MaterialApp(
        title: 'Flutter Astro Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainMenuScreen(),
        routes: {
          MainMenuScreen.routeName: (ctx) => MainMenuScreen(),
          MealHomeScreen.routeName: (ctx) => MealHomeScreen(),
          BeverageHomeScreen.routeName: (ctx) => BeverageHomeScreen(),
        },
      ),
    );
  }
}
