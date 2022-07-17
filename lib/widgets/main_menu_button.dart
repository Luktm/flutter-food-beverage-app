import 'package:astro_test/utils/constant_util.dart';
import 'package:flutter/material.dart';

class MainMenuButton extends StatelessWidget {
  final String title;
  final String itemCount;
  final String imgUrl;
  final Function()? onTap;

  const MainMenuButton({Key? key, required this.title, required this.itemCount, required this.onTap, required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: K.font_md_bold_black,
                  ),
                  Text(
                    itemCount.toString() + " Items",
                    style: K.font_sm_grey,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(imgUrl),
              ),
            ),
          ),
          Positioned(
            right: 5,
            bottom: 0,
            top: 0,
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.chevron_right,
                color: Colors.red[900],
              ),
            ),
          )
        ],
      ),
    );
  }
}
