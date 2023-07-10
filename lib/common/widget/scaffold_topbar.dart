import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';

import '../navigation/navigation_service.dart';

class ScaffoldTopBar extends StatelessWidget {
  final String name;
  final bool showBackButton;

  const ScaffoldTopBar(
      {super.key, required this.name, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: Theme.of(context).primaryColor,
          image: DecorationImage(
              image: AssetImage(
                  RepositoryProvider.of<CoOperative>(context).backgroundImage),
              fit: BoxFit.cover),
        ),
        child: Row(
          children: [
            showBackButton
                ? IconButton(
                    onPressed: () {
                      NavigationService.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )
                : Container(),
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
        ));
  }
}
