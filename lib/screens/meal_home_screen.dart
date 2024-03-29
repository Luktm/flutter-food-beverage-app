import 'package:astro_test/cubit/fnb_category_cubit.dart';
import 'package:astro_test/cubit/popular_fnb_cubit.dart';
import 'package:astro_test/models/detail_argument.dart';
import 'package:astro_test/screens/meal_detail_screen.dart';
import 'package:astro_test/utils/constant_util.dart';
import 'package:astro_test/widgets/delivering_location.dart';
import 'package:astro_test/widgets/home_scaffold.dart';
import 'package:astro_test/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
class MealHomeScreen extends StatefulWidget {
  static const routeName = '/meal_home_screen';

  const MealHomeScreen({Key? key}) : super(key: key);

  @override
  State<MealHomeScreen> createState() => _MealHomeScreenState();
}

class _MealHomeScreenState extends State<MealHomeScreen> {
  TextEditingController controller = TextEditingController();
  String defaultCategoryName = "Beef";

  @override
  void initState() {
    super.initState();
    context.read<FNBCategoryCubit>().fetchMealCategories();
    context.read<PopularFNBCubit>().fetchMealsByCategoryName(name: defaultCategoryName);
  }

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DeliveringLocation(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchInput(controller: controller),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 130,
              width: double.infinity,
              child: BlocConsumer<FNBCategoryCubit, FNBCategoryState>(
                listener: (context, state) {
                  if(state is FNBCategoryFetched) {
                    
                  }
                },
                builder: (context, state) {
                  if (state is FNBCategoryFetched) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      children: List.generate(state.categories.length, (index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                final String categoryName =
                                    state.categories[index].strCategory;
                                if (defaultCategoryName == categoryName) {
                                  return;
                                }
                                defaultCategoryName = categoryName;
                                context
                                    .read<PopularFNBCubit>()
                                    .fetchMealsByCategoryName(
                                        name: categoryName);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black12),
                                    child: Image.network(
                                      state.categories[index].strCategoryThumb,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    state.categories[index].strCategory,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Popular Food",
                  textAlign: TextAlign.left,
                  style: K.font_md_bold_black.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            BlocBuilder<PopularFNBCubit, PopularFNBState>(
              builder: (context, state) {
                if (state is PopularFNBFetched) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: ListView.builder(
                        itemCount: state.popularMeals.length,
                        itemBuilder: (BuildContext context, int index) {
                          final meal = state.popularMeals[index];

                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(context, MealDetailScreen.routeName, arguments: DetailArgument(
                              id: meal.idMeal!,
                            )),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        meal.strMealThumb ?? "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 20,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        meal.strMeal ?? "",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: K.primaryColor,
                                          ),
                                          Text('4.9', style: TextStyle(color: K.primaryColor)),
                                          const SizedBox(width: 5),
                                          const Text("(124 ratings)"),
                                          const SizedBox(width: 5),
                                          Text('•', style: TextStyle(color: K.primaryColor)),
                                          const SizedBox(width: 5),
                                          Text(defaultCategoryName),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
