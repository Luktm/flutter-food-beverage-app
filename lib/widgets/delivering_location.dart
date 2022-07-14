import 'package:astro_test/utils/constant_util.dart';
import 'package:flutter/material.dart';

class DeliveringLocation extends StatelessWidget {
  const DeliveringLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Delivering to", style: K.font_sm_grey),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                "Current Location",
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              const SizedBox(width: 30),
              Icon(Icons.keyboard_arrow_down, color: K.primaryColor)
            ],
          )
        ],
      ),
    );
  }
}
