import 'package:flutter/material.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class ForexWidget extends StatefulWidget {
  const ForexWidget({super.key});

  @override
  State<ForexWidget> createState() => _ForexWidgetState();
}

class _ForexWidgetState extends State<ForexWidget> {
  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
        showBackButton: true,
        showChatBot: false,
        body: Center(
          child: Text('This is foreex'),
        ));
  }
}
