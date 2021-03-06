import 'package:astro_test/cubit/fnb_category_cubit.dart';
import 'package:astro_test/cubit/fnb_detail_cubit.dart';
import 'package:astro_test/cubit/popular_fnb_cubit.dart';
import 'package:astro_test/models/detail_argument.dart';
import 'package:astro_test/repository/fnb_repository.dart';
import 'package:astro_test/screens/beverage_detail_screen.dart';
import 'package:astro_test/screens/beverage_home_screen.dart';
import 'package:astro_test/screens/meal_detail_screen.dart';
import 'package:astro_test/screens/meal_home_screen.dart';
import 'package:astro_test/utils/constant_util.dart';
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

    FNBCategoryCubit fnbGategoryCubit = FNBCategoryCubit(fnbRepository: mealRepository);
    PopularFNBCubit popularMealCubit = PopularFNBCubit(fnbRepository: mealRepository);
    FNBDetailCubit mealDetailCubit = FNBDetailCubit(fnbRepository: mealRepository);
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<FNBCategoryCubit>(create: (ctx) => fnbGategoryCubit),
        BlocProvider<PopularFNBCubit>(create: (ctx) => popularMealCubit),
        BlocProvider<FNBDetailCubit>(create: (ctx) => mealDetailCubit),
      ],
      child: MaterialApp(
        title: 'Flutter Astro Test',
        theme: ThemeData(
          primaryColor: K.primaryColor,
        ),
        home: const MainMenuScreen(),
        onGenerateRoute: (RouteSettings settings) {
          if(settings.name  == MealDetailScreen.routeName) {
            final DetailArgument args = settings.arguments as DetailArgument;
            
            return MaterialPageRoute(builder: (ctx) {
              return MealDetailScreen(id: args.id);
            });
          }

          if(settings.name  == BeverageDetailScreen.routeName) {
            final DetailArgument args = settings.arguments as DetailArgument;
            return MaterialPageRoute(builder: (ctx) {
              return BeverageDetailScreen(id: args.id);
            });
          }
          
        },
        routes: {
          MainMenuScreen.routeName: (ctx) => const MainMenuScreen(),
          MealHomeScreen.routeName: (ctx) => const MealHomeScreen(),
          BeverageHomeScreen.routeName: (ctx) => const BeverageHomeScreen(),
        },
      ),
    );
  }
}
