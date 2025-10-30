import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class PreferenceWidget extends StatefulWidget {
  const PreferenceWidget({super.key});

  @override
  State<PreferenceWidget> createState() => _PreferenceWidgetState();
}

class _PreferenceWidgetState extends State<PreferenceWidget> {
  bool _isChatBotVisible = true;
  // bool _transactionLow = false;

  @override
  void initState() {
    super.initState();
    _loadChatBotVisibility();
    // _loadcompactListVisibility();
  }

  // For transacation list compactness
  // Future<void> _loadcompactListVisibility() async {
  //   final isCompact = await SharedPref.getRecentTransVisibility();
  //   setState(() {
  //     _transactionLow = isCompact;
  //   });
  // }

  // Future<void> _compactListVisibility(bool value) async {
  //   await SharedPref.setRecentTransVisibility(value);
  //   setState(() {
  //     _transactionLow = value;
  //   });
  // }

// for ChatBot visibility
  Future<void> _loadChatBotVisibility() async {
    final isVisible = await SharedPref.getChatBotVisibility();
    setState(() {
      _isChatBotVisible = isVisible;
    });
  }

  Future<void> _toggleChatBotVisibility(bool value) async {
    await SharedPref.setChatBotVisibility(value);
    setState(() {
      _isChatBotVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWrapper(
          body: CommonContainer(
        showRoundBotton: false,
        body: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwitchListTile(
                  //  activeColor: CustomTheme.primaryColor.withOpacity(.9),
                  activeTrackColor: CustomTheme.primaryColor,
                  // inactiveThumbColor: CustomTheme.darkGray,

                  // hoverColor: CustomTheme.primaryColor,
                  title: const Text(
                    'Show ChatBot',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: CustomTheme.lightTextColor),
                  ),
                  value: _isChatBotVisible,
                  onChanged: (value) {
                    _toggleChatBotVisibility(value);
                  }),
              const Divider(),
              // SwitchListTile(
              //     //  activeColor: CustomTheme.primaryColor.withOpacity(.9),
              //     activeTrackColor: CustomTheme.primaryColor,
              //     // inactiveThumbColor: CustomTheme.darkGray,

              //     // hoverColor: CustomTheme.primaryColor,
              //     title: const Text(
              //       'Transaction Compact View',
              //       style: TextStyle(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w500,
              //           color: CustomTheme.lightTextColor),
              //     ),
              //     value: _transactionLow,
              //     onChanged: (value) {
              //       _compactListVisibility(value);
              //     }),
            ],
          ),
        ),
        topbarName: "Preferences",
      )),
    );
  }
}
