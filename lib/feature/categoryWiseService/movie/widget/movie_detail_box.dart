import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';

class MovieDetailBox extends StatelessWidget {
  final String title;
  final String containerImage;
  final Function()? onContainerPress;
  final EdgeInsets? margin;
  final double? height;
  final double? width;

  const MovieDetailBox(
      {super.key,
      this.margin = const EdgeInsets.all(8),
      required this.title,
      this.onContainerPress,
      this.height,
      this.width,
      required this.containerImage});
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onContainerPress,
        child: Column(
          children: [
            Image.network(
              containerImage,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                  RepositoryProvider.of<CoOperative>(context).coOperativeLogo),
            ),
            SizedBox(height: 5.hp),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: _theme.textTheme.displaySmall!.copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
