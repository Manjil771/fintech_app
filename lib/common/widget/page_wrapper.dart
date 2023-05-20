import 'package:flutter/material.dart';

class PageWrapper extends StatefulWidget {
  final bool useOwnAppBar;
  final Widget body;
  final bool useOwnScaffold;
  final bool showAppBar;
  final PreferredSizeWidget? appBar;
  const PageWrapper({
    this.useOwnAppBar = false,
    required this.body,
    this.useOwnScaffold = false,
    this.showAppBar = true,
    this.appBar,
  });
  @override
  _PageWrapperState createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  @override
  Widget build(BuildContext context) {
    if (widget.useOwnScaffold) {
      return widget.body;
    } else {
      return Scaffold(
        appBar: widget.showAppBar
            ? (widget.useOwnAppBar ? widget.appBar : AppBar())
            : null,
        body: widget.body,
      );
    }
  }
}
