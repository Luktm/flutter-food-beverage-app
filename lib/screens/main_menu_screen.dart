import 'dart:math';

import 'package:astro_test/models/meal_argument.dart';
import 'package:astro_test/screens/beverage_home_screen.dart';
import 'package:astro_test/screens/meal_home_screen.dart';
import 'package:astro_test/widgets/home_scaffold.dart';
import 'package:astro_test/widgets/main_menu_button.dart';
import 'package:astro_test/widgets/search_input.dart';
import 'package:astro_test/widgets/square_painter.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatefulWidget {
  static const routeName = "/main_menu_screen";

  MainMenuScreen({Key? key}) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
        title: "Menu",
        body: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: SquarePainter(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Center(
                          child: SearchInput(
                            key: Key("main_menu_screen_search_field"),
                            controller: controller,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                MainMenuButton(
                  title: "Food",
                  imgUrl: "https://i.picsum.photos/id/488/1772/1181.jpg?hmac=psl3qLyDefO6AYqU4TJQ8PNCjS8RdPiP_vRLB8WPVjY",
                  itemCount: Random().nextInt(1000).toString(),
                  onTap: () =>
                      Navigator.pushNamed(context, MealHomeScreen.routeName),
                ),
                SizedBox(
                  height: 25,
                ),
                MainMenuButton(
                  title: "Beverages",
                  imgUrl: "https://i.picsum.photos/id/431/5398/3599.jpg?hmac=bc325kFqsm626RGhgs-XwG_GFqd4x3VmXtramO12qL8",
                  itemCount: Random().nextInt(1000).toString(),
                  onTap: () => Navigator.pushNamed(
                      context, BeverageHomeScreen.routeName),
                ),
              ],
            ),
          ],
        ));
  }
}
