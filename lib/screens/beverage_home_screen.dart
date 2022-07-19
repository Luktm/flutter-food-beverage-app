import 'package:astro_test/cubit/fnb_category_cubit.dart';
import 'package:astro_test/cubit/popular_fnb_cubit.dart';
import 'package:astro_test/models/detail_argument.dart';
import 'package:astro_test/screens/beverage_detail_screen.dart';
import 'package:astro_test/screens/meal_detail_screen.dart';
import 'package:astro_test/utils/constant_util.dart';
import 'package:astro_test/widgets/delivering_location.dart';
import 'package:astro_test/widgets/home_scaffold.dart';
import 'package:astro_test/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeverageHomeScreen extends StatefulWidget {
  static const routeName = '/beverage_home_screen';

  const BeverageHomeScreen({Key? key}) : super(key: key);

  @override
  State<BeverageHomeScreen> createState() => _BeverageHomeScreenState();
}

class _BeverageHomeScreenState extends State<BeverageHomeScreen> {
  TextEditingController controller = TextEditingController();
  String defaultCategoryName = "";

  @override
  void initState() {
    super.initState();
    context.read<FNBCategoryCubit>().fetchBeverageCategories();
    context.read<PopularFNBCubit>().fetchBeverageByCategoryName(name: defaultCategoryName);
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
              height: 50,
              width: double.infinity,
              child: BlocBuilder<FNBCategoryCubit, FNBCategoryState>(
                builder: (context, state) {
                  if (state is FNBCategoryFetched) {
                  
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      children: List.generate(state.beveragecategories.length,
                          (index) {
                      var beverageCategory = state.beveragecategories[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if(defaultCategoryName == beverageCategory.strCategory) {
                                  return;
                                }
                                
                                 defaultCategoryName = state.beveragecategories[index].strCategory.split("/").first.trim();

                                 if(defaultCategoryName == "Ordinary Drink") {
                                  defaultCategoryName = "";
                                 }
                                
                                context.read<PopularFNBCubit>().fetchBeverageByCategoryName(name: defaultCategoryName);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(right: 15),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black12),
                                child: Text(
                                  state.beveragecategories[index].strCategory,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Popular Drink",
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

                  if(state.popularBeverages.isEmpty) return Center(child: Text('Sorry, unable to find $defaultCategoryName, please try difference beverage', textAlign: TextAlign.center,),);                  
                  
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: ListView.builder(
                        itemCount: state.popularBeverages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final drink = state.popularBeverages[index];
                          return GestureDetector(
                             onTap: () => Navigator.pushNamed(context, BeverageDetailScreen.routeName, arguments: DetailArgument(
                              id: drink.idDrink!,
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
                                        drink.strDrinkThumb ?? "",
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
                                        drink.strDrink ?? "",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: K.primaryColor,
                                          ),
                                          Text('4.9',
                                              style: TextStyle(
                                                  color: K.primaryColor)),
                                          SizedBox(width: 5),
                                          Text("(124 ratings)"),
                                          SizedBox(width: 5),
                                          Text('•',
                                              style: TextStyle(
                                                  color: K.primaryColor)),
                                          SizedBox(width: 5),
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

                if(state is PopularFNBFailedFetch) {
                  return Text(state.message);
                }
                
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
