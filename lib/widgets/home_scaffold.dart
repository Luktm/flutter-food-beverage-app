import 'package:astro_test/utils/constant_util.dart';
import 'package:flutter/material.dart';

class HomeScaffold extends StatelessWidget {
  final Widget body;
  final String? title;

  const HomeScaffold({Key? key, required this.body, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Set true if you want back icon
        iconTheme: IconThemeData(
          color: K.primaryColor, //change your color here
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
             "Good morning Akila!",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black87,
              ),
            )
          ],
        ),
      ),
      body: body,
    );
  }
}
