import 'dart:io';

import 'package:astro_test/cubit/fnb_detail_cubit.dart';
import 'package:astro_test/models/meal.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:astro_test/models/ingredient_measure.dart';
import 'package:astro_test/models/meals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = "/meal_detail_screen";
  final String id;

  const MealDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _servingAmount = 1;

  @override
  void initState() {
    super.initState();
    context.read<FNBDetailCubit>().fetchMealDetailById(id: widget.id);

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizedBox _sizedBox = const SizedBox(width: 5);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FNBDetailCubit, FNBDetailState>(
        builder: (context, state) {
          if (state is FNBDetailFetched) {
            final Meal mealDetail = state.mealDetail.meals![0];
            List<IngredientMeasure> populateIngredient =
                _populateIngredientMeasure(mealDetail);

            return Builder(builder: (context) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      snap: false,
                      pinned: false,
                      floating: false,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              mealDetail.strMealThumb ??
                                  "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png",
                              fit: BoxFit.cover,
                              colorBlendMode: BlendMode.multiply,
                              color: Colors.white,
                            ),
                            Positioned(
                              top: 80,
                              left: 10,
                              child: Row(
                                children: [
                                  Icon(Icons.star_outlined),
                                  Text("4.5"),
                                  _sizedBox,
                                  Text("•"),
                                  _sizedBox,
                                  Text("15:06"),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 150,
                              left: 10,
                              child: GestureDetector(
                                onTap: () => _launchURL(url: mealDetail.strYoutube),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.play_arrow_rounded, size: 50),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      expandedHeight: 230,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 4,
                                    child: Row(
                                      children: [
                                        Icon(Icons.chat_outlined, size: 30),
                                        _sizedBox,
                                        Text("350"),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.star_border_rounded,
                                              size: 40),
                                          Icon(Icons.bookmark_border, size: 30),
                                          Icon(Icons.share_outlined, size: 30),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TabBar(
                                controller: _tabController,
                                // give the indicator a decoration (color and border radius)
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5.0,
                                  ),
                                  color: Theme.of(context).primaryColor,
                                ),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(
                                    child: Text(
                                      "Ingredient",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "Steps",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "Nutrition",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ingredient for",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "$_servingAmount servings",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      _servingButton(
                                        context: context,
                                        onTap: () => setState(() {
                                          _servingAmount++;
                                        }),
                                        icon: Icons.add,
                                      ),
                                      _sizedBox,
                                      _sizedBox,
                                      Text("$_servingAmount",
                                          style: TextStyle(fontSize: 25)),
                                      _sizedBox,
                                      _sizedBox,
                                      _servingButton(
                                        context: context,
                                        onTap: () {
                                          if (_servingAmount <= 1) {
                                            return;
                                          }
                                          setState(() {
                                            _servingAmount--;
                                          });
                                        },
                                        icon: Icons.remove,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    _customSrollView(populateIngredient: populateIngredient),
                    _customSrollView(populateIngredient: populateIngredient),
                    _customSrollView(populateIngredient: populateIngredient),
                  ],
                ),
              );
            });
          }

          if (state is FNBDetailFailedFetch) {
            return Text(state.message);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  List<IngredientMeasure> _populateIngredientMeasure(Meal mealDetail) {
    return [
      IngredientMeasure(
        ingredient: mealDetail.strIngredient1,
        measure: mealDetail.strMeasure1,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient2,
        measure: mealDetail.strMeasure2,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient3,
        measure: mealDetail.strMeasure3,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient4,
        measure: mealDetail.strMeasure4,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient5,
        measure: mealDetail.strMeasure5,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient6,
        measure: mealDetail.strMeasure6,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient7,
        measure: mealDetail.strMeasure7,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient8,
        measure: mealDetail.strMeasure8,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient9,
        measure: mealDetail.strMeasure9,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient10,
        measure: mealDetail.strMeasure10,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient11,
        measure: mealDetail.strMeasure11,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient12,
        measure: mealDetail.strMeasure12,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient13,
        measure: mealDetail.strMeasure13,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient14,
        measure: mealDetail.strMeasure14,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient15,
        measure: mealDetail.strMeasure15,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient16,
        measure: mealDetail.strMeasure16,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient17,
        measure: mealDetail.strMeasure17,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient18,
        measure: mealDetail.strMeasure18,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient19,
        measure: mealDetail.strMeasure19,
      ),
      IngredientMeasure(
        ingredient: mealDetail.strIngredient20,
        measure: mealDetail.strMeasure20,
      ),
    ];
  }

  Widget _customSrollView({
    required List<IngredientMeasure> populateIngredient,
  }) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final ingredientMeasure = populateIngredient[index];

              return ListTile(
                tileColor: Colors.white,
                title: Text(
                  ingredientMeasure.ingredient != null &&
                          ingredientMeasure.ingredient!.isNotEmpty
                      ? ingredientMeasure.ingredient!
                      : "NIL",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  ingredientMeasure.measure != null &&
                          ingredientMeasure.measure!.isNotEmpty
                      ? ingredientMeasure.measure!
                      : "NIL",
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png",
                  ),
                ),
              );
            },
            childCount: populateIngredient.length,
          ),
        ),
      ],
    );
  }

  SizedBox _servingButton(
      {required BuildContext context,
      Function()? onTap,
      required IconData icon}) {
    return SizedBox.fromSize(
      size: Size(40, 40), // button width and height
      child: ClipOval(
        child: Material(
          color: Theme.of(context).primaryColor, // button color
          child: InkWell(
            splashColor: Colors.red[800], // splash color
            onTap: onTap, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL({String? url}) async {
    if (url != null) {
      final parsedUrl = Uri.parse(url);
      if (Platform.isIOS) {
        if (await canLaunchUrl(parsedUrl)) {
          await launchUrl(parsedUrl);
        } else {
          if (await canLaunchUrl(parsedUrl)) {
            await launchUrl(parsedUrl);
          } else {
            throw 'Could not launch $parsedUrl';
          }
        }
      } else {
        if (await canLaunchUrl(parsedUrl)) {
          await launchUrl(parsedUrl);
        } else {
          throw 'Could not launch $url';
        }
      }
    }
  }
}
