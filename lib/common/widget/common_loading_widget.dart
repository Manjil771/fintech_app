import 'package:flutter/cupertino.dart';
import 'package:ismart/common/constant/assets.dart';

class CommonLoadingWidget extends StatelessWidget {
  const CommonLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        Assets.logoImage,
        height: 100,
        width: 100,
      ),
    );
  }
}
