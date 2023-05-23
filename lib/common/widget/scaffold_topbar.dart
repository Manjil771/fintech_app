import 'package:flutter/material.dart';
import 'package:ismart/common/constant/env.dart';

class ScaffoldTopBar extends StatelessWidget {
  final String name;
  final bool back;

  const ScaffoldTopBar({super.key, required this.name, required this.back});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        color: Theme.of(context).primaryColor,
        image: DecorationImage(
            image: AssetImage(CoOperativeValue.development.bannerImage),
            fit: BoxFit.cover),
      ),
      child: back == true
          ? Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                    child: Center(
                  child: Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "popinsemibold",
                        fontSize: 23),
                  ),
                )),
              ],
            )
          : Center(
              child: Text(
                name,
                style:
                    const TextStyle(fontFamily: "popinsemibold", fontSize: 23),
              ),
            ),
    );
  }
}
